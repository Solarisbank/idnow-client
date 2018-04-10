# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'download default document', :stub_connect do
  subject { client.download_default_document(document_definition_identifier) }

  let(:document_definition_identifier) { 'testdoc' }
  let(:response_body) { 'Example file for specs' }

  before do
    login
  end

  let!(:request) do
    stub_request(:get, idnow_url("/documentdefinitions/#{document_definition_identifier}/data"))
      .with(headers: { 'X-Api-Login-Token' => 'nekoThtua' })
      .to_return(status: 200, body: response_body, headers: {})
  end

  context 'when the document definition is sucessful' do
    let(:response_body) { '{}' }
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
