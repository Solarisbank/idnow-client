require 'spec_helper'
require 'pry'

RSpec.describe IdnowRuby::PostRequest do
  let(:path) { 'api/v1/company_id/identifications/1234555/start' }
  let(:identification_data) { build(:identification_data) }
  let(:post_request) { IdnowRuby::PostRequest.new(path, identification_data) }
  describe '#new' do
    subject { post_request }
    it 'adds a application/json content type' do
      expect(subject['Content-Type']).to eq 'application/json'
    end

    it 'sets the body to the json identification data transfomation' do
      expect(subject.body).to eq identification_data.to_json
    end
  end
end
