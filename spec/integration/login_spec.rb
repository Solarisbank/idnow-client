require 'spec_helper'

describe IdnowRuby::Client do
  let(:client) { IdnowRuby::Client.new(host: host, company_id: company_id, api_key: api_key) }
  let(:host) { IdnowRuby::Host::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }

  describe '#login' do
    subject { client.login }

    let(:body) { { apiKey: api_key } }

    context 'whent the login is successfull' do
      let!(:request) do
        stub_request(:post, "#{host}/api/v1/#{company_id}/login")
          .with(body: body,
                headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key.to_s })
          .to_return(status: 200, body: '{ "authToken": "nekoThtua"}', headers: {})
      end

      it 'makes a request to the server' do
        subject
        expect(request).to have_been_made
      end
    end

    context 'when the identification returns errros' do
      let!(:request) do
        stub_request(:post, "#{host}/api/v1/#{company_id}/login")
          .with(body: body,
                headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key.to_s })
          .to_return(status: 400, body: '{ "errors": [{
                                                "cause": "INVALID_LOGIN_TOKEN",
                                                "id": "487800773",
                                                "key": null,
                                                "message": null
                                           }]
                                         }'
                    )
      end

      it { expect { subject }.to raise_error(IdnowRuby::ResponseException) }
    end
  end
end
