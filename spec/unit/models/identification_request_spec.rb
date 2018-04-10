# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow::IdentificationRequest do
  let(:successful_id) { 'IBA-H5FD8' }
  let(:json_data) { Idnow::JsonResponse.new("{ \"id\": \"#{successful_id}\" }").data }
  let(:transaction_number) { 12_345 }
  let(:host) { Idnow::ENVIRONMENTS[:test][:target_host] }
  let(:company_id) { 'company_id' }
  let(:identification_request) { Idnow::IdentificationRequest.new(json_data, transaction_number, host, company_id) }

  describe '#id' do
    subject { identification_request.id }
    it 'returns the id' do
      is_expected.to eq 'IBA-H5FD8'
    end
  end

  describe '#redirect_url' do
    subject { identification_request.redirect_url }

    it 'returns a test redirect url' do
      is_expected.to eq "https://go.test.idnow.de/#{company_id}/identifications/#{transaction_number}"
    end
  end
end
