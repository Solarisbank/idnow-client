require 'spec_helper'

RSpec.describe IdnowRuby::Response do
  let(:idnow_response) { IdnowRuby::Response.new(response) }
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

  describe '#errors' do
    subject { idnow_response.errors }
    context 'given raw response without errors' do
      let(:response) { successful_raw_response }
      it 'returns nil' do
        expect(subject).to eq nil
      end
    end

    context 'given a raw response with errors ' do
      let(:response) { failure_raw_response }
      it 'returns the errors' do
        expect(subject).to eq(
          [
            { 'cause' => 'SOMETHING_WRONG' }
          ]
        )
      end
    end
  end

  describe '#errors?' do
    subject { idnow_response.errors? }
    context 'given raw response without errors' do
      let(:response) { successful_raw_response }
      it { is_expected.to be_falsey }
    end

    context 'given a raw response with errors ' do
      let(:response) { failure_raw_response }
      it { is_expected.to be_truthy }
    end
  end
end
