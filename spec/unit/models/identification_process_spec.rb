require 'spec_helper'

RSpec.describe Idnow::IdentificationProcess do
  let(:identification_process) { Idnow::IdentificationProcess.new(data_hash) }

  let(:data_hash) do
    {
      'result' => result,
      'reason' => 'STALLED_TIMEOUT',
      'companyid' => 'ihrebank',
      'agentname' => 'TROBOT',
      'filename' => '12345.zip',
      'identificationtime' => '2016-02-10T15 =>02 =>42+01 =>00',
      'id' => 'TST-UMCJU',
      'href' => '/api/v1/solarisbank/identifications/18.zip',
      'type' => 'WEB',
      'transactionnumber' => '12345'
    }
  end

  let(:result) { 'SUCCESS' }

  describe '#result' do
    subject { identification_process.result }
    it { is_expected.to eq result }
  end

  describe '#reason' do
    subject { identification_process.reason }
    it { is_expected.to eq 'STALLED_TIMEOUT' }
  end

  describe '#company_id' do
    subject { identification_process.company_id }
    it { is_expected.to eq 'ihrebank' }
  end

  describe '#agentname' do
    subject { identification_process.agentname }
    it { is_expected.to eq 'TROBOT' }
  end

  describe '#filename' do
    subject { identification_process.filename }
    it { is_expected.to eq '12345.zip' }
  end

  describe '#identification_time' do
    subject { identification_process.identification_time }
    it { is_expected.to eq '2016-02-10T15 =>02 =>42+01 =>00' }
  end

  describe '#id' do
    subject { identification_process.id }
    it { is_expected.to eq 'TST-UMCJU' }
  end

  describe '#href' do
    subject { identification_process.href }
    it { is_expected.to eq '/api/v1/solarisbank/identifications/18.zip' }
  end

  describe '#type' do
    subject { identification_process.type }
    it { is_expected.to eq 'WEB' }
  end

  describe '#transaction_number' do
    subject { identification_process.transaction_number }
    it { is_expected.to eq '12345' }
  end

  describe '#successful?' do
    subject { identification_process.successful? }
    context 'when result was SUCCESS' do
      let(:result) { 'SUCCESS' }
      it { is_expected.to be_truthy }
    end

    context 'whe result was SUCCESS_DATA_CHANGED' do
      let(:result) { 'SUCCESS_DATA_CHANGED' }
      it { is_expected.to be_truthy }
    end

    context 'when result is not SUCCESS or SUCCES_DATA_CHANGED' do
      let(:result) { 'FAIL' }
      it { is_expected.to be_falsey }
    end
  end
end
