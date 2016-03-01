require 'spec_helper'

RSpec.describe Idnow::Identification do
  include_context 'idnow api responses'

  subject { identification }
  it { should delegate_method(:result).to(:identification_process) }
  it { should delegate_method(:reason).to(:identification_process) }
  it { should delegate_method(:id).to(:identification_process) }
  it { should delegate_method(:transaction_number).to(:identification_process) }
  it { should delegate_method(:successful?).to(:identification_process) }

  let(:identification) { Idnow::Identification.new(success_identification_hash) }

  describe '#identification_process' do
    subject { identification.identification_process }
    it 'returns an indentification process' do
      expect(subject).to be_a Idnow::IdentificationProcess
    end
  end

  describe '#contact_data' do
    subject { identification.contact_data }
    it 'returns an indentification process' do
      expect(subject).to eq({
                              'mobilephone' => '+4915193875727462264',
                              'email' => 'petra.meier@example.com'
                            })
    end
  end

  describe '#user_data' do
    subject { identification.user_data }
    it 'returns an indentification process' do
      expect(subject).to be_a Idnow::UserData
    end
  end

  describe '#identification_document' do
    subject { identification.identification_document }
    it 'returns an indentification process' do
      expect(subject).to eq(nil)
    end
  end

  describe '#attachments' do
    subject { identification.attachments }
    it 'returns an indentification process' do
      expect(subject).to eq({
                              'pdf' => '28.pdf',
                              'audiolog' => '28.mp3',
                              'xml' => '28.xml',
                              'idbackside' => '28_idbackside.jpg',
                              'idfrontside' => '28_idfrontside.jpg',
                              'userface' => '28_userface.jpg'
                            })
    end
  end
end
