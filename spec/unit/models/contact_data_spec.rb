# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow::ContactData do
  let(:contact_data) { build(:idnow_identification).contact_data }

  describe '#email' do
    subject { contact_data.email }
    it { is_expected.to eq 'petra.meier@example.com' }
  end

  describe '#mobilephone' do
    subject { contact_data.mobilephone }
    it { is_expected.to eq '+4915193875727' }
  end
end
