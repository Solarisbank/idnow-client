require 'spec_helper'

RSpec.describe Idnow::PostBinaryRequest do
  let(:path) { 'api/v1/company_id/identifications/any/path' }
  let(:data) { %w(some thing).pack('B*') }
  let(:post_request) { Idnow::PostBinaryRequest.new(path, data) }

  describe '#new' do
    subject { post_request }
    it 'adds a application/json content type' do
      expect(subject['Content-Type']).to eq 'application/octet-stream'
    end
  end
end
