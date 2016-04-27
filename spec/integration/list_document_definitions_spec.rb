require 'spec_helper'

RSpec.describe 'list document definitions', :stub_connect do
  subject { client.list_document_definitions }

  before do
    login
  end

  let!(:request) do
    stub_request(:get, idnow_url('/documentdefinitions'))
      .with(headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Login-Token' => 'nekoThtua' })
      .to_return(status: 200, body: response_body, headers: {})
  end

  let(:document_definition_json) { build(:idnow_document_definition).to_json }

  context 'when the document definition is sucessful' do
    let(:response_body) do
      <<-JSON
      [
        #{document_definition_json}
      ]
      JSON
    end

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
