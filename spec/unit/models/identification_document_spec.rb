# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow::IdentificationDocument do
  let(:identification_document) { described_class.new(data) }

  let(:data) do
    JSON.parse(
      '{
        "country": {
          "value": "DE",
          "status": "NEW"
        },
        "number": {
          "value": "123456789",
          "status": "NEW"
        },
        "issuedby": {
          "value": "ISSUER",
          "status": "NEW"
        },
        "dateissued": {
          "value": "2010-10-12",
          "status": "NEW"
        },
        "type": {
          "value": "IDCARD",
          "status": "NEW"
        },
        "validuntil": {
          "value": "2020-10-11",
          "status": "NEW"
        }
      }'
    )
  end

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
    it { is_expected.to eq(Date.parse('2010-10-12')) }
  end

  describe '#type' do
    subject { identification_document.type }
    it { is_expected.to eq 'IDCARD' }
  end

  describe '#valid_until' do
    subject { identification_document.valid_until }
    it { is_expected.to eq(Date.parse('2020-10-11')) }
  end

  context 'Invalid data' do
    let(:data) { {} }

    describe '#country' do
      subject { identification_document.country }
      it { is_expected.to eq nil }
    end

    describe '#number' do
      subject { identification_document.number }
      it { is_expected.to eq nil }
    end

    describe '#issued_by' do
      subject { identification_document.issued_by }
      it { is_expected.to eq nil }
    end

    describe '#date_issued' do
      subject { identification_document.date_issued }
      it { is_expected.to eq nil }
    end

    describe '#type' do
      subject { identification_document.type }
      it { is_expected.to eq nil }
    end

    describe '#valid_until' do
      subject { identification_document.valid_until }
      it { is_expected.to eq nil }
    end
  end
end
