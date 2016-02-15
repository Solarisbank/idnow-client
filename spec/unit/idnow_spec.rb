require 'spec_helper'

describe Idnow do
  it 'has a version number' do
    expect(Idnow::VERSION).not_to be nil
  end

  describe '.env=' do
    before do
      Idnow.instance_variable_set(:@host, 'http://any-host.com')
      Idnow.instance_variable_set(:@target_host, 'http://any-redirect-host.com')
    end
    subject { Idnow.env = env }

    context 'if :test env is given' do
      let(:env) { :test }
      it 'resets client' do
        Idnow.instance_variable_set(:@client, 'dummy')
        expect { subject }.to change { Idnow.instance_variable_get(:@client) }.to(nil)
      end
      it 'sets the host to Idnow::Host::TEST_SERVER' do
        expect { subject }.to change { Idnow.instance_variable_get(:@host) }.to(Idnow::Host::TEST_SERVER)
      end
      it 'sets the target_host to Idnow::TargetHost::TEST_SERVER' do
        expect { subject }.to change { Idnow.instance_variable_get(:@target_host) }.to(Idnow::TargetHost::TEST_SERVER)
      end
    end

    context 'if :live env is given' do
      let(:env) { :live }
      it 'resets client' do
        Idnow.instance_variable_set(:@client, 'dummy')
        expect { subject }.to change { Idnow.instance_variable_get(:@client) }.to(nil)
      end
      it 'sets the host to Idnow::Host::LIVE_SERVER' do
        expect { subject }.to change { Idnow.instance_variable_get(:@host) }.to(Idnow::Host::LIVE_SERVER)
      end
      it 'sets the target_host to Idnow::TargetHost::LIVE_SERVER' do
        expect { subject }.to change { Idnow.instance_variable_get(:@target_host) }.to(Idnow::TargetHost::LIVE_SERVER)
      end
    end

    context 'if an invalid env is given' do
      let(:env) { :invalid }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe '.company_id=' do
    before do
      Idnow.company_id = 'anycompany'
    end
    subject { Idnow.company_id = company_id }

    let(:company_id) { 'somecompany' }

    it 'resets client' do
      Idnow.instance_variable_set(:@client, 'dummy')
      expect { subject }.to change { Idnow.instance_variable_get(:@client) }.to(nil)
    end

    it 'sets company_id' do
      expect { subject }.to change { Idnow.instance_variable_get(:@company_id) }.to(company_id)
    end
  end

  describe '.api_key=' do
    before do
      Idnow.api_key = 'anykey'
    end
    subject { Idnow.api_key = api_key }

    let(:api_key) { 'api_key' }

    it 'resets client' do
      Idnow.instance_variable_set(:@client, 'dummy')
      expect { subject }.to change { Idnow.instance_variable_get(:@client) }.to(nil)
    end

    it 'sets api_key' do
      expect { subject }.to change { Idnow.instance_variable_get(:@api_key) }.to(api_key)
    end
  end

  describe '.test_env?' do
    subject { Idnow.test_env? }
    context 'when no env was set' do
      before do
        Idnow.instance_variable_set(:@host, nil)
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set env to :test or :live') }
    end

    context 'when env was set to :test' do
      before do
        Idnow.env = :test
      end
      it { is_expected.to be_truthy }
    end

    context 'when env was set to :live' do
      before do
        Idnow.env = :live
      end
      it { is_expected.to be_falsey }
    end
  end

  describe '.client' do
    subject { Idnow.client }

    context 'if company_id is not set' do
      before do
        Idnow.instance_variable_set(:@company_id, nil)
        Idnow.instance_variable_set(:@host, 'host')
        Idnow.instance_variable_set(:@api_key, 'api_key')
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set your company_id') }
    end

    context 'if api_key is not set' do
      before do
        Idnow.instance_variable_set(:@api_key, nil)
        Idnow.instance_variable_set(:@company_id, 'somecompany')
        Idnow.instance_variable_set(:@host, 'host')
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set your api_key') }
    end

    context 'if env is not set' do
      before do
        Idnow.instance_variable_set(:@host, nil)
        Idnow.instance_variable_set(:@api_key, 'api_key')
        Idnow.instance_variable_set(:@company_id, 'some_company')
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set env to :test or :live') }
    end

    context 'if env, api_key and company_id are set' do
      before do
        Idnow.env = :test
        Idnow.company_id = 'somecompany'
        Idnow.api_key = 'some key'
        Idnow.instance_variable_set(:@client, nil)
      end

      it { is_expected.to be_a(Idnow::Client) }

      it 'memoizes the client' do
        expect(Idnow::Client).to receive(:new).once.and_call_original
        2.times { Idnow.client }
      end
    end
  end
end
