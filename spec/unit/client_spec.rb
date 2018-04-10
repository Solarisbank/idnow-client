# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow::Client do
  let(:client) { Idnow::Client.new(env: env, company_id: company_id, api_key: api_key) }
  let(:env) { :test }
  let(:expected_sftp_host) { Idnow::Host::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }

  it 'has pending and failed identification statuses' do
    expect(Idnow::Client::IDENTIFICATION_STATUSES - %w[failed pending]).to be_empty
  end

  describe '.initialize' do
    context 'when a timeout option is passed' do
      it 'initializes Idnow::SftpClient with that timeout' do
        expect(Idnow::SftpClient).to receive(:new)
          .with(host: expected_sftp_host, username: company_id, password: api_key, timeout: 123)

        Idnow::Client.new(env: env, company_id: company_id, api_key: api_key, timeout: 123)
      end
    end

    context 'when no timeout option is passed' do
      it 'initializes Idnow::SftpClient with no timeout' do
        expect(Idnow::SftpClient).to receive(:new)
          .with(host: expected_sftp_host, username: company_id, password: api_key)

        Idnow::Client.new(env: env, company_id: company_id, api_key: api_key)
      end
    end

    context 'when a custom set of endpoints is configured' do
      around do |example|
        Idnow.custom_environments = { test: { host: 'https://gateway.test.idnow.example.com' } }
        example.run
        Idnow.custom_environments = nil
      end

      it 'initializes http and sftp clients with the custom hosts' do
        expect(Idnow::HttpClient).to receive(:new)
          .with(host: 'https://gateway.test.idnow.example.com')
        expect(Idnow::SftpClient).to receive(:new)
          .with(host: 'https://gateway.test.idnow.example.com', username: company_id, password: api_key)

        Idnow::Client.new(env: env, company_id: company_id, api_key: api_key)
      end
    end
  end

  describe '#list_identifications' do
    let(:status) { nil }
    subject { client.list_identifications(status: status) }

    context 'when the user did not log in' do
      before do
        client.instance_variable_set(:@auth_token, nil)
      end
      it { expect { subject }.to raise_error Idnow::AuthenticationException }
    end

    context 'when the user logged in' do
      before do
        client.instance_variable_set(:@auth_token, 'token')
      end

      context 'when an invalid status is given' do
        let(:status) { 'invalid' }
        it { expect { subject }.to raise_error Idnow::InvalidArguments }
      end

      context 'when a valid status is given' do
        let(:status) { 'failed' }
        let(:http_client_double) do
          response_double = double
          allow(response_double).to receive(:body).and_return('{ "identifications": [] } ')
          instance_double(Idnow::HttpClient, execute: response_double)
        end

        before do
          client.instance_variable_set(:@http_client, http_client_double)
        end

        it 'executes the request' do
          expect(http_client_double).to receive(:execute)
          subject
        end
      end

      context 'when no status is given' do
        let(:status) { nil }
        let(:http_client_double) do
          response_double = double
          allow(response_double).to receive(:body).and_return('{ "identifications": [] }')
          instance_double(Idnow::HttpClient, execute: response_double)
        end

        before do
          client.instance_variable_set(:@http_client, http_client_double)
        end

        it 'executes the request' do
          expect(http_client_double).to receive(:execute)
          subject
        end
      end
    end
  end

  describe '#get_identification' do
    subject { client.get_identification(transaction_number: 1234) }

    context 'when the user did not log in' do
      before do
        client.instance_variable_set(:@auth_token, nil)
      end
      it { expect { subject }.to raise_error Idnow::AuthenticationException }
    end

    context 'when the user logged in' do
      let(:http_client_double) do
        response_double = double(:response, body: success_identification_json)
        instance_double(Idnow::HttpClient, execute: response_double)
      end

      let(:success_identification_json) { build(:idnow_identification_hash).to_json }

      before do
        client.instance_variable_set(:@auth_token, 'token')
        client.instance_variable_set(:@http_client, http_client_double)
      end

      it 'executes the request' do
        expect(http_client_double).to receive(:execute)
        subject
      end
    end
  end

  describe '#upload_identification_document' do
    subject { client.upload_identification_document(transaction_number, document_definition_identifier, file_data) }
    let(:transaction_number) { '12345' }
    let(:document_definition_identifier) { 'cool_doc' }
    let(:file_data) { File.read('spec/support/test_files/example.txt') }

    # log in user
    before do
      client.instance_variable_set(:@auth_token, 'token')
    end

    context 'when the user did not log in' do
      before do
        client.instance_variable_set(:@auth_token, nil)
      end
      it { expect { subject }.to raise_error Idnow::AuthenticationException }
    end

    context 'when the user logged in and sent a valid file' do
      let(:http_client_double) do
        response_double = double
        allow(response_double).to receive(:body).and_return('{ "identifications": [] } ')
        instance_double(Idnow::HttpClient, execute: response_double)
      end

      before do
        client.instance_variable_set(:@http_client, http_client_double)
      end

      it 'executes the request' do
        expect(http_client_double).to receive(:execute)
        subject
      end
    end
  end

  describe 'list_cached_document_definitions' do
    subject { client.list_cached_document_definitions(refresh) }

    let(:refresh) { false }

    before do
      client.instance_variable_set(:@auth_token, 'token')
      allow(client).to receive(:list_document_definitions).and_return(%w[doc1 doc2])
    end

    context 'when the document definitions are not cached' do
      before { client.instance_variable_set(:@list_cached_document_definitions, nil) }

      it 'calls list_document_definitions' do
        expect(client).to receive(:list_document_definitions).and_return(%w[doc1 doc2])
        subject
      end

      it 'sets @list_cached_document_definitions' do
        subject
        expect(client.instance_variable_get(:@list_cached_document_definitions)).to eq %w[doc1 doc2]
      end

      it 'returns the document definitions' do
        expect(subject).to eq(%w[doc1 doc2])
      end
    end

    context 'when the document definitions are cached' do
      before { client.instance_variable_set(:@list_cached_document_definitions, %w[doc1 doc2]) }

      it 'does not call list_document_definitions' do
        expect(client).not_to receive(:list_document_definitions)
        subject
      end

      it { is_expected.to eq %w[doc1 doc2] }
    end

    context 'when the refresh flag is true' do
      let(:refresh) { true }

      before do
        client.instance_variable_set(:@list_cached_document_definitions, %w[doc1 doc2])
        allow(client).to receive(:list_document_definitions).and_return(['doc3'])
      end

      it 'always calls list_document_definitions' do
        expect(client).to receive(:list_document_definitions).and_return(['doc3'])
        subject
      end

      it 'updates @document_definitions' do
        subject
        expect(client.instance_variable_get(:@list_cached_document_definitions)).to eq ['doc3']
      end

      it 'returns the document definitions' do
        allow(client).to receive(:list_document_definitions).and_return(['doc3'])
        expect(subject).to eq(['doc3'])
      end
    end
  end
end
