# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow::RawResponse do
  let(:idnow_response) { Idnow::RawResponse.new(response) }
  let(:successful_raw_response) { 'was successful' }
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

    it 'sets raw' do
      expect(subject.raw).to eq 'was successful'
    end
  end

  describe '#errors' do
    subject { idnow_response.errors }
    context 'given raw response without errors' do
      let(:response) { successful_raw_response }
      it 'returns nil' do
        is_expected.to eq nil
      end
    end

    context 'given a raw response with errors ' do
      let(:response) { failure_raw_response }
      it 'returns the errors' do
        is_expected.to eq(
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
