# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow::IdentificationData do
  let(:object) { Idnow::IdentificationData.new(params) }
  let(:params) { {} }

  describe '#to_json' do
    subject { object.to_json }

    context 'when no data is given' do
      it { is_expected.to eq '{}' }
    end

    context 'when valid data is given' do
      let(:params) { { city: 'Berlin', birthday: '30.10.1983' } }

      it { is_expected.to eq '{"birthday":"1983-10-30","city":"Berlin"}' }
    end

    context 'when invalid attribute is passed' do
      let(:params) { { invalid_attribute: 'some value' } }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe 'birthday attribute' do
    subject { object.birthday }

    context 'when Date object is given' do
      before { object.birthday = Date.new(1984, 5, 19) }

      it { is_expected.to eq('1984-05-19') }
    end

    context 'when DateTime object is given' do
      before { object.birthday = DateTime.new(1984, 5, 19, 16, 30, 45) }

      it { is_expected.to eq('1984-05-19') }
    end
    context 'when parsable String is given' do
      before { object.birthday = '1984-05-19, 16:30 CEST' }

      it { is_expected.to eq('1984-05-19') }
    end

    it 'throws an error if no proper date is given' do
      expect { object.birthday = 'some random string' }.to raise_error(ArgumentError)
    end
  end

  describe 'country attribute' do
    subject { object.country }

    context 'when uppercase ISO 3166 country code is given' do
      before { object.country = 'DE' }

      it { is_expected.to eq('DE') }
    end

    context 'when lowercase ISO 3166 country code is given' do
      before { object.country = 'de' }

      it { is_expected.to eq('DE') }
    end

    it 'throws an error if no proper country code is given' do
      expect { object.country = 'abc' }.to raise_error(ArgumentError)
    end
  end

  describe 'country attribute' do
    subject { object.gender }

    ['MALE', 'M', 'male', 'm', :MALE, :M, :male, :m].each do |valid_male_value|
      context "when gender is set to #{valid_male_value}" do
        before { object.gender = valid_male_value }

        it { is_expected.to eq('MALE') }
      end
    end

    ['FEMALE', 'F', 'female', 'f', :FEMALE, :F, :female, :f].each do |valid_female_value|
      context "when gender is set to #{valid_female_value}" do
        before { object.gender = valid_female_value }

        it { is_expected.to eq('FEMALE') }
      end
    end

    context 'when gender is set to invalid value' do
      it { expect { object.gender = 'hybrid' }.to raise_error(ArgumentError) }
    end
  end
end
