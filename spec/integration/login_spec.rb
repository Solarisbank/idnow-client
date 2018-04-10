# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'login', :stub_connect do
  subject { client.login }

  let!(:request) do
    stub_request(:post, idnow_url('/login'))
      .with(body: body,
            headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby' })
      .to_return(status: status, body: response_body, headers: {})
  end
  let(:body) { { apiKey: api_key } }

  context 'whent the login is successfull' do
    let(:status) { 200 }
    let(:response_body) do
      <<-JSON
      {
        "authToken": "nekoThtua"
      }
      JSON
    end

    it 'makes a request to the server' do
      subject
      expect(request).to have_been_made
    end
  end

  context 'when the identification returns errros' do
    let(:status) { 400 }
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
