require 'spec_helper'

RSpec.describe 'list identifications', :stub_connect do
  subject { client.list_identifications }

  let!(:request) do
    stub_request(:get, idnow_url("/identifications"))
      .with(headers: { 'Content-Type' => 'application/json', 'X-Api-Login-Token' => 'nekoThtua' })
      .to_return(status: status, body: response_body)
  end
  let(:success_identification_json) { build(:idnow_identification_hash).to_json }

  before do
    login
  end

  context 'when the listing is successfull' do
    let(:status) { 200 }
    let(:response_body) { <<-JSON
      {
        "identifications": [
          #{success_identification_json}
        ]
      }
      JSON
    }

    it 'makes a request to the server' do
      subject
      expect(request).to have_been_made
    end

    it { is_expected.to be_a Array }

    it 'returns an Array with Idnow::Identification objects' do
      expect(subject[0]).to be_a Idnow::Identification
    end
  end

  context 'when the identification returns errros' do
    let(:status) { 401 }
    let(:response_body) { <<-JSON
      {
        "errors": [{
          "cause": "TOKEN_EXPIRED"
        }]
      }
      JSON
    }

    it { expect { subject }.to raise_error(Idnow::ResponseException) }
  end
end
