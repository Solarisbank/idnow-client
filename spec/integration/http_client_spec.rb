require 'spec_helper'

describe Idnow::HttpClient do
  let(:http_client) { Idnow::HttpClient.new(host: host, api_key: api_key) }
  let(:post_request) { Idnow::PostRequest.new(path, {}) }
  let(:path) { "#{host}/some/path" }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:api_key) { 'api_key' }

  describe '#execute' do
    subject { http_client.execute(post_request) }
    context 'whent the request is successfull' do
      let!(:request) do
        stub_request(:post, path)
          .with(body: '{}',
                headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby' })
          .to_return(status: 200, body: '{ "authToken": "nekoThtua"}', headers: {})
      end

      it 'makes a request to the server' do
        subject
        expect(request).to have_been_made
      end
    end

    context 'when the request to idnow throws an exception' do
      let!(:request) do
        stub_request(:post, path)
          .with(body: '{}',
                headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby' })
          .to_raise(Timeout::Error)
      end

      it { expect { subject }.to raise_error(Idnow::ConnectionException) }
    end
  end
end
