require 'spec_helper'

RSpec.describe Idnow::IdentificationRequest do
  let(:successful_id) { 'IBA-H5FD8' }
  let(:json_data) { Idnow::Response.new("{ \"id\": \"#{successful_id}\" }").data }
  let(:transaction_number) { 12_345 }
  let(:identification_request) { Idnow::IdentificationRequest.new(json_data, transaction_number) }

  describe '#id' do
    subject { identification_request.id }
    it 'returns the id' do
      is_expected.to eq 'IBA-H5FD8'
    end
  end

  describe '#redirect_url' do
    subject { identification_request.redirect_url }
    context 'when env is :test' do
      before do
        Idnow.env = :test
      end
      it 'returns a test redirect url' do
        is_expected.to eq "https://go.test.idnow.de/#{Idnow.company_id}/identifications/#{transaction_number}/identification/start"
      end
    end
    context 'when env is :live' do
      before do
        Idnow.env = :live
      end
      it 'returns a live redirect url' do
        is_expected.to eq "https://go.idnow.de/#{Idnow.company_id}/identifications/#{transaction_number}/identification/start"
      end
    end
  end
end
