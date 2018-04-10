# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'get identification', :stub_connect do
  subject { client.get_identification(transaction_number: transaction_number) }

  let(:transaction_number) { '12345' }

  before do
    login
  end

  let!(:request) do
    stub_request(:get, idnow_url("/identifications/#{transaction_number}"))
      .with(headers: { 'Content-Type' => 'application/json', 'X-Api-Login-Token' => 'nekoThtua' })
      .to_return(status: status, body: response_body)
  end

  context 'when the identification is successfully retrieved' do
    let(:status) { 200 }
    let(:response_body) { build(:idnow_identification_hash).to_json }

    it 'makes a request to the server' do
      subject
      expect(request).to have_been_made
    end
  end

  context 'when the identification returns errros' do
    let(:status) { 401 }
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
