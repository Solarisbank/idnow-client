require 'spec_helper'

RSpec.describe Idnow::HttpClient do
  let(:host) { 'https://www.example.com:3000' }
  let(:http_client) { Idnow::HttpClient.new(host: host) }

  describe '#new' do
    subject { http_client }

    it 'parses the host into a URI' do
      expect(subject.instance_variable_get('@uri')).to be_a URI
    end
  end

  describe '#execute' do
    subject { http_client.execute(post_request) }

    let(:post_request) { Idnow::PostRequest.new(path, {}) }
    let(:path) { "#{host}/some/path" }

    context 'whent the request is successfull' do
      let!(:request) do
        stub_request(:post, path)
          .with(body: '{}', headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby' })
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
