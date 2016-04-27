require 'spec_helper'

RSpec.describe Idnow::DocumentDefinition do
  let(:document_definition) { build(:idnow_document_definition) }

  describe '#optional' do
    subject { document_definition.optional }
    it { is_expected.to be_falsey }
  end

  describe '#name' do
    subject { document_definition.name }
    it { is_expected.to eq 'Arbeitsvertrag' }
  end

  describe '#identifier' do
    subject { document_definition.identifier }
    it { is_expected.to eq 'doc1' }
  end

  describe '#mime_type' do
    subject { document_definition.mime_type }
    it { is_expected.to eq 'application/pdf' }
  end

  describe '#sort_order' do
    subject { document_definition.sort_order }
    it { is_expected.to eq 1 }
  end
end
