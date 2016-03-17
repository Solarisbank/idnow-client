require 'spec_helper'

RSpec.describe 'create document definition', :stub_connect do
  subject { client.create_document_definition(document_data) }

  let(:document_data) do
    {
      "optional": true,
      "name": 'SomeDoc',
      "identifier": 'sdoc1',
      "mimeType": 'text/rtf',
      "sortOrder": 1
    }
  end

  before do
    login
  end

  let!(:request) do
    stub_request(:post, idnow_url('/documentdefinitions'))
      .with(body: document_data,
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Login-Token' => 'nekoThtua' })
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
