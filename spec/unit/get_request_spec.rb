# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow::GetRequest do
  let(:path) { 'api/v1/company_id/login' }
  let(:get_request) { Idnow::GetRequest.new(path) }

  describe '#new' do
    subject { get_request }
    it 'adds a application/json content type' do
      expect(subject['Content-Type']).to eq 'application/json'
    end
  end
end
