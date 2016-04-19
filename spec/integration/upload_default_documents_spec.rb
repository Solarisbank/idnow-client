require 'spec_helper'

RSpec.describe 'upload default documents', :stub_connect do
  subject { client.upload_default_document(document_definition_identifier, file_data) }

  let(:document_definition_identifier) { 'testdoc' }
  let(:file_path) { 'spec/support/test_files/example.txt' }
  let(:file_data) { File.read(file_path) }

  before do
    login
  end

  let!(:request) do
    stub_request(:post, idnow_url("/documentdefinitions/#{document_definition_identifier}/data"))
      .with(body: file_data,
            headers: { 'Content-Type' => 'application/octet-stream', 'X-Api-Login-Token' => 'nekoThtua' })
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
