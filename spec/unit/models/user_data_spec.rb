require 'spec_helper'

RSpec.describe Idnow::UserData do
  include_context 'idnow api responses'

  let(:user_data) { Idnow::UserData.new(user_data_hash) }

  describe '#birthday' do
    subject { user_data.birthday }
    it { is_expected.to eq '2002-02-02' }
  end

  describe '#firstname' do
    subject { user_data.firstname }
    it { is_expected.to eq 'Mr Potatoe' }
  end

  describe '#zipcode' do
    subject { user_data.zipcode }
    it { is_expected.to eq '12345' }
  end

  describe '#country' do
    subject { user_data.country }
    it { is_expected.to eq 'DE' }
  end

  describe '#city' do
    subject { user_data.city }
    it { is_expected.to eq 'CITY' }
  end

  describe '#street' do
    subject { user_data.street }
    it { is_expected.to eq 'STREET' }
  end

  describe '#streetnumber' do
    subject { user_data.streetnumber }
    it { is_expected.to eq '1' }
  end

  describe '#birthplace' do
    subject { user_data.birthplace }
    it { is_expected.to eq 'BIRTHPLACE' }
  end

  describe '#nationality' do
    subject { user_data.nationality }
    it { is_expected.to eq 'DE' }
  end

  describe '#last_name' do
    subject { user_data.lastname }
    it { is_expected.to eq 'LASTNAME' }
  end

  describe '#address' do
    subject { user_data.address }
    it { is_expected.to eq 'STREET 1, 12345 CITY, DE' }
  end
end
