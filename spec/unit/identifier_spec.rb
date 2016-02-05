require 'spec_helper'

RSpec.describe IdnowRuby::Identifier do
  let(:identifier) { IdnowRuby::Identifier.new(args) }
  let(:args) { { company_id: 'sun', host: 'host', api_key: 'api_key' } }

  describe '#new' do
    subject { identifier }

    context 'with no host' do
      let(:args) { { company_id: 1, api_key: 'api_key' } }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with no company_id' do
      let(:args) { { host: 'host', api_key: 'api_key' } }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with no api_key' do
      let(:args) { { host: 'host', company_id: 'company_id' } }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
