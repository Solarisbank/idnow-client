require 'spec_helper'

RSpec.describe 'testing_request_video_chat', :stub_connect  do
  subject { client.testing_request_video_chat(transaction_number: transaction_number) }

  let(:transaction_number) { '12345' }

  let!(:request) do
    stub_request(:post, idnow_url("/identifications/#{transaction_number}/requestVideoChat", host: Idnow::API::AutomatedTesting::HOST))
    .with(body: '{}', headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key })
    .to_return(status: status, body: response_body)
  end

  context 'when starting the automated testing is successful' do
    let(:status) { 200 }
    let(:response_body) { <<-JSON
      {}
      JSON
    }

    it 'makes a request to the server' do
      subject
      expect(request).to have_been_made
    end
  end

  context 'when starting the mautomated testing returns errros' do
    let(:status) { 401 }
    let(:response_body) { <<-JSON
      {
        "errors": [
          {
            "cause": "OBJECT_NOT_FOUND",
            "id": "76424268",
            "key": "transactionToken",
            "message": null
          }
        ]
      }
      JSON
    }
    it { expect { subject }.to raise_error(Idnow::ResponseException) }
  end
end
