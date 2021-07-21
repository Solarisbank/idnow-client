# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'get identification file', :stub_connect do
  subject { client.get_identification_file(transaction_number: transaction_number) }

  let(:transaction_number) { '12345' }

  before do
    login
  end

  let!(:request) do
    stub_request(:get, idnow_url("/identifications/#{transaction_number}.zip"))
      .with(headers: { 'X-Api-Login-Token' => 'nekoThtua' })
      .to_return(status: status, body: response_body)
  end

  context 'when the identification is successfully retrieved' do
    let(:status) { 200 }
    let(:response_body) { 'BINARY' }

    it 'makes a request to the server' do
      subject
      expect(request).to have_been_made
    end

    it 'allows accessing the raw binary' do
      expect(subject).to be_a Idnow::RawResponse
      expect(subject.raw).to eq 'BINARY'
    end
  end

  context 'when the identification returns errros' do
    let(:status) { 404 }
    let(:response_body) do
      <<-JSON
      {
        "errors": [{
            "cause":"OBJECT_NOT_FOUND",
            "id":"12345","key":"token",
            "message":"No identification found matching the provided parameters"
          }]
        }
      JSON
    end

    it { expect { subject }.to raise_error(Idnow::ResponseException) }
  end
end
