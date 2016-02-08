require 'spec_helper'

describe IdnowRuby do
  it 'has a version number' do
    expect(IdnowRuby::VERSION).not_to be nil
  end

  describe '.env=' do
    before do
      IdnowRuby.instance_variable_set(:@host, 'http://any-host.com')
    end
    subject { IdnowRuby.env = env }

    context 'if :test env is given' do
      let(:env) { :test }
      it 'resets identifier' do
        IdnowRuby.instance_variable_set(:@identifier, 'dummy')
        expect { subject }.to change { IdnowRuby.instance_variable_get(:@identifier) }.to(nil)
      end
      it 'sets the host to IdnowRuby::TEST_SERVER' do
        expect { subject }.to change { IdnowRuby.instance_variable_get(:@host) }.to(IdnowRuby::TEST_SERVER)
      end
    end

    context 'if :live env is given' do
      let(:env) { :live }
      it 'resets identifier' do
        IdnowRuby.instance_variable_set(:@identifier, 'dummy')
        expect { subject }.to change { IdnowRuby.instance_variable_get(:@identifier) }.to(nil)
      end
      it 'sets the host to IdnowRuby::TEST_SERVER' do
        expect { subject }.to change { IdnowRuby.instance_variable_get(:@host) }.to(IdnowRuby::LIVE_SERVER)
      end
    end

    context 'if an invalid env is given' do
      let(:env) { :invalid }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe '.company_id=' do
    before do
      IdnowRuby.company_id = 'anycompany'
    end
    subject { IdnowRuby.company_id = company_id }

    let(:company_id) { 'somecompany' }

    it 'resets identifier' do
      IdnowRuby.instance_variable_set(:@identifier, 'dummy')
      expect { subject }.to change { IdnowRuby.instance_variable_get(:@identifier) }.to(nil)
    end

    it 'sets company_id' do
      expect { subject }.to change { IdnowRuby.instance_variable_get(:@company_id) }.to(company_id)
    end
  end

  describe '.api_key=' do
    before do
      IdnowRuby.api_key = 'anykey'
    end
    subject { IdnowRuby.api_key = api_key }

    let(:api_key) { 'api_key' }

    it 'resets identifier' do
      IdnowRuby.instance_variable_set(:@identifier, 'dummy')
      expect { subject }.to change { IdnowRuby.instance_variable_get(:@identifier) }.to(nil)
    end

    it 'sets api_key' do
      expect { subject }.to change { IdnowRuby.instance_variable_get(:@api_key) }.to(api_key)
    end
  end

  describe '.test_env?' do
    subject { IdnowRuby.test_env? }
    context 'when no env was set' do
      before do
        IdnowRuby.instance_variable_set(:@host, nil)
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set env to :test or :live') }
    end

    context 'when env was set to :test' do
      before do
        IdnowRuby.env = :test
      end
      it { is_expected.to be_truthy }
    end

    context 'when env was set to :live' do
      before do
        IdnowRuby.env = :live
      end
      it { is_expected.to be_falsey }
    end
  end

  describe '.identifier' do
    subject { IdnowRuby.identifier }

    context 'if company_id is not set' do
      before do
        IdnowRuby.instance_variable_set(:@company_id, nil)
        IdnowRuby.instance_variable_set(:@host, 'host')
        IdnowRuby.instance_variable_set(:@api_key, 'api_key')
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set your company_id') }
    end

    context 'if api_key is not set' do
      before do
        IdnowRuby.instance_variable_set(:@api_key, nil)
        IdnowRuby.instance_variable_set(:@company_id, 'somecompany')
        IdnowRuby.instance_variable_set(:@host, 'host')
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set your api_key') }
    end

    context 'if env is not set' do
      before do
        IdnowRuby.instance_variable_set(:@host, nil)
        IdnowRuby.instance_variable_set(:@api_key, 'api_key')
        IdnowRuby.instance_variable_set(:@company_id, 'some_company')
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set env to :test or :live') }
    end

    context 'if env, api_key and company_id are set' do
      before do
        IdnowRuby.env = :test
        IdnowRuby.company_id = 'somecompany'
        IdnowRuby.api_key = 'some key'
        IdnowRuby.instance_variable_set(:@identifier, nil)
      end

      it { is_expected.to be_a(IdnowRuby::Identifier) }

      it 'memoizes the identifier' do
        expect(IdnowRuby::Identifier).to receive(:new).once.and_call_original
        2.times { IdnowRuby.identifier }
      end
    end
  end
end
