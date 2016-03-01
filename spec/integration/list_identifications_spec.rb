require 'spec_helper'

describe Idnow::Client do
  include_context 'idnow api responses'

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
          .to_return(status: 200, body: "{
                                              \"identifications\": [
                                              #{success_identification_json}
                                              ]
                                            }")
      end

      it 'makes a request to the server' do
        subject
        expect(list_identifications_request).to have_been_made
      end

      it { is_expected.to be_a Array }

      it 'returns an Array with Idnow::Identification objects' do
        expect(subject[0]).to be_a Idnow::Identification
      end
    end

    context 'when the identification returns errros' do
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
