require 'spec_helper'

RSpec.describe Idnow::Identification do
  subject { identification }

  let(:identification) { build(:idnow_identification, esigning: esigning) }
  let(:esigning) { false }

  describe 'delegators' do
    it { should delegate_method(:result).to(:identification_process) }
    it { should delegate_method(:reason).to(:identification_process) }
    it { should delegate_method(:id).to(:identification_process) }
    it { should delegate_method(:transaction_number).to(:identification_process) }
    it { should delegate_method(:successful?).to(:identification_process) }
    it { should delegate_method(:review_pending?).to(:identification_process) }
  end

  describe '#identification_process' do
    subject { identification.identification_process }
    it 'returns an indentification process' do
      is_expected.to be_a Idnow::IdentificationProcess
    end
  end

  describe '#contact_data' do
    subject { identification.contact_data }
    it 'returns an indentification process' do
      is_expected.to be_a Idnow::ContactData
    end
  end

  describe '#user_data' do
    subject { identification.user_data }
    it 'returns an indentification process' do
      is_expected.to be_a Idnow::UserData
    end
  end

  describe '#identification_document' do
    subject { identification.identification_document }

    it 'returns an indentification document' do
      is_expected.to be_a Idnow::IdentificationDocument
    end

    context 'when the initialization hash does not have a identificationdocument key' do
      let(:idnow_identification_hash) { build(:idnow_identification_hash).tap { |hs| hs.delete('identificationdocument') } }
      let(:identification) { build(:idnow_identification, idnow_identification_hash: idnow_identification_hash, esigning: false) }

      it 'returns an indentification document' do
        is_expected.to be_a Idnow::IdentificationDocument
      end
    end
  end

  describe '#attachments' do
    subject { identification.attachments }
    it 'returns an indentification process' do
      is_expected.to eq({
                          'pdf' => '28.pdf',
                          'audiolog'    => '28.mp3',
                          'xml'         => '28.xml',
                          'idbackside'  => '28_idbackside.jpg',
                          'idfrontside' => '28_idfrontside.jpg',
                          'userface'    => '28_userface.jpg'
                        })
    end
  end

  describe '#esigning?' do
    subject { identification.esigning? }
    context 'with esigning' do
      let(:esigning) { true }
      it { is_expected.to be_truthy }
    end

    context 'without esigning' do
      let(:esigning) { false }
      it { is_expected.to be_falsey }
    end
  end

  describe '#esigning' do
    subject { identification.esigning }
    context 'with esigning' do
      let(:esigning) { true }
      it 'returns an esigning' do
        is_expected.to eq({
                            'result' => 'SUCCESS',
                            'sessionid' => '3XIDNOW-SERVID01-_-20160330140640-7B4C7736M47BE285'
                          })
      end
    end

    context 'without esigning' do
      let(:esigning) { false }
      it { is_expected.to be_nil }
    end
  end

  describe 'raw_data' do
    subject { identification.raw_data }
    it { is_expected.to eq build(:idnow_identification_hash) }
  end
end
