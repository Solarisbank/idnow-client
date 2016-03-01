require 'spec_helper'

RSpec.describe Idnow::IdentificationProcess do
  include_context 'idnow api responses'

  let(:identification_process) { Idnow::IdentificationProcess.new(identification_process_hash) }

  let(:result) { 'SUCCESS' }

  describe '#result' do
    subject { identification_process.result }
    it { is_expected.to eq result }
  end

  describe '#reason' do
    subject { identification_process.reason }
    it { is_expected.to be_nil }
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
    it { is_expected.to eq '28.zip' }
  end

  describe '#identification_time' do
    subject { identification_process.identification_time }
    it { is_expected.to eq '2016-02-25T13:51:20+01:00' }
  end

  describe '#id' do
    subject { identification_process.id }
    it { is_expected.to eq 'TST-XLFYB' }
  end

  describe '#href' do
    subject { identification_process.href }
    it { is_expected.to eq '/api/v1/ihrebank/identifications/28.zip' }
  end

  describe '#type' do
    subject { identification_process.type }
    it { is_expected.to eq 'WEB' }
  end

  describe '#transaction_number' do
    subject { identification_process.transaction_number }
    it { is_expected.to eq '28' }
  end

  describe '#successful?' do
    subject { identification_process.successful? }
    context 'when result was SUCCESS' do
      before { identification_process.instance_variable_set('@result', 'SUCCESS') }
      it { is_expected.to be_truthy }
    end

    context 'whe result was SUCCESS_DATA_CHANGED' do
      before { identification_process.instance_variable_set('@result', 'SUCCESS_DATA_CHANGED') }
      it { be_truthy }
    end

    context 'when result is not SUCCESS or SUCCES_DATA_CHANGED' do
      before do
        identification_process.instance_variable_set('@result', "FRAUD_SUSPICION_CON
      FIRMED")
      end
      it { is_expected.to be_falsey }
    end
  end
end
