require 'spec_helper'

describe Idnow::Client do
  let(:client) { Idnow::Client.new(host: host, company_id: company_id, api_key: api_key) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }

  describe '#list_identifications' do
    subject { client.list_identifications }

    let!(:login_request) do
      stub_request(:post, "#{host}/api/v1/#{company_id}/login")
        .with(body: '{"apiKey":"api_key"}')
        .to_return(status: 200, body: '{ "authToken": "nekoThtua"}', headers: {})
    end

    before do
      client.login
    end

    context 'when the listing is successfull' do
      let!(:list_identifications_request) do
        stub_request(:get, "#{host}/api/v1/#{company_id}/identifications")
          .with(headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Login-Token' => 'nekoThtua' })
          .to_return(status: 200, body: '{
                                              "identifications": [{
                                                "identificationprocess": {
                                                    "result": "SUCCESS",
                                                    "agentname": "HMUELLER",
                                                    "identificationtime": "2014-06-02T05:03:54Z",
                                                    "type": "WEB",
                                                    "transactionnumber": "AH73JK3LM",
                                                    "companyid":"ihrebank",
                                                    "id": "IBA-H7GB6",
                                                    "filename":"AH73JK3LM.zip",
                                                    "href": "/api/v1/ihrebank/identifications/AH73JK3LM.zip"
                                                  }
                                              }]
                                            }')
      end

      it 'makes a request to the server' do
        subject
        expect(list_identifications_request).to have_been_made
      end
    end

    context 'when the identification returns errros' do
      subject { client.list_identifications }
      let!(:request) do
        stub_request(:get, "#{host}/api/v1/#{company_id}/identifications")
          .with(headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby' })
          .to_return(status: 401, body: '{ "errors": [{
                                                "cause": "TOKEN_EXPIRED"
                                           }]
                                         }'
                    )
      end

      it { expect { subject }.to raise_error(Idnow::ResponseException) }
    end
  end
end
