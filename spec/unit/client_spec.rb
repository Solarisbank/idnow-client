
require 'spec_helper'

describe Idnow::Client do
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
          allow(response_double).to receive(:body).and_return('{ "body": "Some body"}')
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
          allow(response_double).to receive(:body).and_return('{ "body": "Some body"}')
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
end
