require 'spec_helper'

RSpec.describe Idnow::Response::StartIdentification do
  let(:successful_id) { 'IBA-H5FD8' }
  let(:successful_raw_response) { "{ \"id\": \"#{successful_id}\" }" }
  let(:failure_raw_response) do
    '{
                                  "errors": [{
                                          "cause": "INVALID_LOGIN_TOKEN"
                                  }]
                                }'
  end
  let(:transaction_number) { 12_345 }
  let(:start_identification_response) { Idnow::Response::StartIdentification.new(response, transaction_number) }

  describe '#id' do
    subject { start_identification_response.id }
    context 'given raw response without errors' do
      let(:response) { successful_raw_response }
      it 'returns the id' do
        expect(subject).to eq 'IBA-H5FD8'
      end
    end

    context 'given a raw response with errors ' do
      let(:response) { failure_raw_response }
      it 'returns nil' do
        expect(subject).to eq nil
      end
    end
  end

  describe '#redirect_url' do
    subject { start_identification_response.redirect_url }
    let(:response) { successful_raw_response }
    context 'when env is :test' do
      before do
        Idnow.env = :test
      end
      it 'returns a test redirect url' do
        expect(subject).to eq "https://go.test.idnow.de/#{Idnow.company_id}/identifications/#{transaction_number}/identification/start"
      end
    end
    context 'when env is :live' do
      before do
        Idnow.env = :live
      end
      it 'returns a live redirect url' do
        expect(subject).to eq "https://go.idnow.de/#{Idnow.company_id}/identifications/#{transaction_number}/identification/start"
      end
    end
  end
end
