require 'spec_helper'

RSpec.describe Idnow::ContactData do
  include_context 'idnow api responses'

  let(:contact_data) { Idnow::ContactData.new(contact_data_hash) }

  describe '#email' do
    subject { contact_data.email }
    it { is_expected.to eq 'petra.meier@example.com' }
  end

  describe '#mobilephone' do
    subject { contact_data.mobilephone }
    it { is_expected.to eq '+4915193875727462264' }
  end
end
