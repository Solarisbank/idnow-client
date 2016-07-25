require 'spec_helper'

RSpec.describe Idnow::UserData do
  let(:user_data) { idnow_identification.user_data }
  let(:idnow_identification) { build(:idnow_identification) }

  describe '#address' do
    subject { user_data.address }
    it { is_expected.to eq 'STREET 1, 12345 CITY, DE' }
  end

  describe '#birthday' do
    subject { user_data.birthday }
    it { is_expected.to eq '2002-02-02' }
  end

  describe '#birthname' do
    subject { user_data.birthname }
    it { is_expected.to eq 'BIRTHNAME' }
  end

  describe '#birthplace' do
    subject { user_data.birthplace }
    it { is_expected.to eq 'BIRTHPLACE' }
  end

  describe '#city' do
    subject { user_data.city }
    it { is_expected.to eq 'CITY' }
  end

  describe '#country' do
    subject { user_data.country }
    it { is_expected.to eq 'DE' }
  end

  describe '#firstname' do
    subject { user_data.firstname }
    it { is_expected.to eq 'Mr Potatoe' }
  end

  describe '#gender' do
    subject { user_data.gender }
    it { is_expected.to eq 'GENDER' }
  end

  describe '#last_name' do
    subject { user_data.lastname }
    it { is_expected.to eq 'LASTNAME' }
  end

  describe '#nationality' do
    subject { user_data.nationality }
    it { is_expected.to eq 'DE' }
  end

  describe '#street' do
    subject { user_data.street }
    it { is_expected.to eq 'STREET' }
  end

  describe '#streetnumber' do
    subject { user_data.streetnumber }
    it { is_expected.to eq '1' }
  end

  describe '#zipcode' do
    subject { user_data.zipcode }
    it { is_expected.to eq '12345' }
  end

  describe '#title' do
    subject { user_data.title }
    it { is_expected.to eq 'TITLE' }
  end

  describe 'address_changed?' do
    subject { user_data.address_changed? }
    let(:idnow_identification) { build(:idnow_identification, idnow_identification_hash: idnow_identification_hash) }
    let(:idnow_identification_hash) { build(:idnow_identification_hash).tap { |h| h['userdata']['address']['city']['status'] = status } }

    context 'status is changed' do
      let(:status) { 'CHANGE' }
      it { is_expected.to be true }
    end

    context 'status is unchanged' do
      let(:status) { 'MATCH' }
      it { is_expected.to be false }
    end
  end
end
