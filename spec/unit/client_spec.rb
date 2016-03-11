require 'spec_helper'

RSpec.describe Idnow::Client do
  let(:client) { Idnow::Client.new(host: host, company_id: company_id, api_key: api_key) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }

  it 'has pending and failed identification statuses' do
    expect(Idnow::Client::IDENTIFICATION_STATUSES - %w(failed pending)).to be_empty
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
end
