require 'spec_helper'

describe IdnowRuby::HttpClient do
  let(:http_client) { IdnowRuby::HttpClient.new(host: host, api_key: api_key) }
  let(:post_request) { IdnowRuby::PostRequest.new(path, {}) }
  let(:path) { "#{host}/some/path" }
  let(:host) { IdnowRuby::Host::TEST_SERVER }
  let(:api_key) { 'api_key' }

  describe '#execute' do
    subject { http_client.execute(post_request) }
    context 'whent the request is successfull' do
      let!(:request) do
        stub_request(:post, path)
          .with(body: '{}',
                headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key.to_s })
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
                headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key.to_s })
          .to_raise(Timeout::Error)
      end

      it { expect { subject }.to raise_error(IdnowRuby::ConnectionException) }
    end
  end
end
