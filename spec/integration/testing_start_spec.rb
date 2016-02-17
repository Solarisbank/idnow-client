require 'spec_helper'

describe Idnow::Client do
  let(:client) { Idnow::Client.new(host: host, company_id: company_id, api_key: api_key) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }
  let(:transaction_number) { '12345' }

  describe '#testing_start' do
    subject { client.testing_start(transaction_number: transaction_number) }

    context 'when starting the automated testing is successful' do
      let!(:request) do
        stub_request(:post, "#{Idnow::Client::AUTOMATED_TESTING_HOST}/api/v1/#{company_id}/identifications/#{transaction_number}/start")
          .with(body: '{}', headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key })
          .to_return(status: 200, body: '{
                                            "token":"0",
                                            "internalToken":"TST-FKQGX",
                                            "status":"STARTED",
                                            "email":null,
                                            "mobile":null,
                                            "trackingId":null,
                                            "testRobotType":"AUTO",
                                            "testRobotName":"happypath",
                                            "request": {
                                                       "status":"NEW",
                                                       "videoSession":"videoSessionToken",
                                                       "userVideoSessionToken": "userVideoSessionToken",
                                                       "positionInQueue":null
                                            }
                                          }')
      end

      it 'makes a request to the server' do
        subject
        expect(request).to have_been_made
      end
    end

    context 'when starting the automated testing returns errros' do
      let!(:request) do
        stub_request(:post, "#{Idnow::Client::AUTOMATED_TESTING_HOST}/api/v1/#{company_id}/identifications/#{transaction_number}/start")
          .with(body: '{}', headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key })
          .to_return(status: 401, body: '{
                                          "errors": [
                                            {
                                              "cause": "OBJECT_NOT_FOUND",
                                              "id": "76424268",
                                              "key": "transactionToken",
                                              "message": null
                                            }
                                          ]
                                        }')
      end
      it { expect { subject }.to raise_error(Idnow::ResponseException) }
    end
  end
end
