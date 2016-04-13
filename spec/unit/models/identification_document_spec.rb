require 'spec_helper'

RSpec.describe Idnow::IdentificationDocument do
  let(:identification_document) { build(:idnow_identification).identification_document }

  describe '#country' do
    subject { identification_document.country }
    it { is_expected.to eq 'DE' }
  end

  describe '#number' do
    subject { identification_document.number }
    it { is_expected.to eq '123456789' }
  end

  describe '#issued_by' do
    subject { identification_document.issued_by }
    it { is_expected.to eq 'ISSUER' }
  end

  describe '#date_issued' do
    subject { identification_document.date_issued }
    it { is_expected.to eq '2010-10-12' }
  end

  describe '#type' do
    subject { identification_document.type }
    it { is_expected.to eq 'IDCARD' }
  end

  describe '#valid_until' do
    subject { identification_document.valid_until }
    it { is_expected.to eq '2020-10-11' }
  end
end
