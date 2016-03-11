require 'spec_helper'

RSpec.describe 'request identification', :stub_connect  do
  subject { client.request_identification(transaction_number: transaction_number, identification_data: identification_data) }

  let(:transaction_number) { '1234567890' }
  let(:identification_data) { build(:idnow_identification_data) }

  let!(:request) do
    stub_request(:post, idnow_url("/identifications/#{transaction_number}/start"))
      .with(body: body, headers: { 'X-Api-Key' => api_key.to_s })
      .to_return(status: 200, body: response_body, headers: {})
  end
  let(:body) do
    JSON.parse(<<-JSON).to_json
    {
      "birthday":"1984-07-20",
      "birthplace":"Buxtehude",
      "birthname":"Meier",
      "city":"Berlin",
      "country":"DE",
      "custom1":"first custom parameter",
      "custom2":"second custom parameter",
      "custom3":"third custom parameter",
      "custom4":"fourth custom parameter",
      "custom5":"fifth custom parameter",
      "trackingid":"track123",
      "email":"petra.meier@example.com",
      "firstname":"Petra",
      "gender":"FEMALE",
      "lastname":"Meier",
      "nationality":"DE",
      "street":"Sesamstraße",
      "streetnumber":"34c",
      "title":"Prof. Dr. Dr. hc",
      "zipcode":"10439"
    }
    JSON
  end

  let(:response_body) do
    <<-JSON
    {
      "id": "IBA-H5FD8"
    }
    JSON
  end

  # TODO: WHY is this not needed??
  # before do
  #   login
  # end

  context 'when the request to idnow is successfull' do
    it 'makes a request to the server' do
      subject
      expect(request).to have_been_made
    end
  end

  context 'when the request to idnow returns errros' do
    let(:response_body) do
      <<-JSON
      {
        "errors": [{
          "cause": "INVALID_LOGIN_TOKEN",
          "id": "487800773",
          "key": null,
          "message": null
        }]
      }
      JSON
    end

    it { expect { subject }.to raise_error(Idnow::ResponseException) }
  end
end
