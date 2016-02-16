require 'spec_helper'

describe Idnow::Client do
  let(:client) { Idnow::Client.new(host: host, company_id: company_id, api_key: api_key) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }
  let(:transaction_number) { '12345' }

  describe '#get_identification' do
    subject { client.get_identification(transaction_number: transaction_number) }

    let!(:login_request) do
      stub_request(:post, "#{host}/api/v1/#{company_id}/login")
        .with(body: '{"apiKey":"api_key"}')
        .to_return(status: 200, body: '{ "authToken": "nekoThtua"}', headers: {})
    end

    before do
      client.login
    end

    context 'when the identification is successfully retrieved' do
      let!(:get_identification_request) do
        stub_request(:get, "#{host}/api/v1/#{company_id}/identifications/#{transaction_number}")
          .with(headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Login-Token' => 'nekoThtua' })
          .to_return(status: 200, body: '{
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
                                          }')
      end

      it 'makes a request to the server' do
        subject
        expect(get_identification_request).to have_been_made
      end
    end

    context 'when the identification returns errros' do
      let!(:request) do
        stub_request(:get, "#{host}/api/v1/#{company_id}/identifications/#{transaction_number}")
          .with(headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Login-Token' => 'nekoThtua' })
          .to_return(status: 401, body: '{"errors": [{
                                              "cause":"OBJECT_NOT_FOUND",
                                              "id":"12345","key":"token",
                                              "message":"No identification found matching the provided parameters"
                                              }]
                                          }'
                    )
      end
      it { expect { subject }.to raise_error(Idnow::ResponseException) }
    end
  end
end
