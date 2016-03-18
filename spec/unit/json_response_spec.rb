require 'spec_helper'

RSpec.describe Idnow::JsonResponse do
  let(:idnow_response) { Idnow::JsonResponse.new(response) }
  let(:successful_raw_response) { '{"was":"successful"}' }
  let(:failure_raw_response) do
    '{
                                  "errors": [{
                                          "cause": "SOMETHING_WRONG"
                                  }]
                                }'
  end

  describe '#new' do
    let(:response) { successful_raw_response }
    subject { idnow_response }
    it 'sets data to the hash resulting of parsing the raw_response' do
      data = subject.instance_variable_get('@data')
      expect(data).to be_a Hash
    end
  end
end
