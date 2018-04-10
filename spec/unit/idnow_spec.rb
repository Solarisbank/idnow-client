# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Idnow do
  after do
    Idnow.instance_variable_set(:@env, nil)
    Idnow.instance_variable_set(:@company_id, nil)
    Idnow.instance_variable_set(:@api_key, nil)
    Idnow.instance_variable_set(:@custom_environments, nil)
    Idnow.instance_variable_set(:@client, nil)
  end

  describe '.env=' do
    subject { Idnow.env = env }

    let(:env) { :test }

    it 'resets client' do
      Idnow.instance_variable_set(:@client, 'dummy')
      expect { subject }.to change { Idnow.instance_variable_get(:@client) }.to(nil)
    end

    it 'sets env' do
      expect { subject }.to change { Idnow.instance_variable_get(:@env) }.to(env)
    end

    context 'when invalid env is given' do
      let(:env) { :invalid }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe '.company_id=' do
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

  describe '.custom_environments=' do
    subject { Idnow.custom_environments = custom_environments }

    let(:custom_environments) { { test: {}, live: {} } }

    it 'resets client' do
      Idnow.instance_variable_set(:@client, 'dummy')
      expect { subject }.to change { Idnow.instance_variable_get(:@client) }.to(nil)
    end

    it 'sets custom_environments' do
      expect { subject }.to change { Idnow.instance_variable_get(:@custom_environments) }.to(custom_environments)
    end
  end

  describe '.client' do
    subject { Idnow.client }

    context 'if company_id is not set' do
      before do
        Idnow.env = :test
        Idnow.api_key = 'some key'
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set your company_id') }
    end

    context 'if api_key is not set' do
      before do
        Idnow.env = :test
        Idnow.company_id = 'somecompany'
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set your api_key') }
    end

    context 'if env is not set' do
      before do
        Idnow.company_id = 'somecompany'
        Idnow.api_key = 'some key'
      end
      it { expect { subject }.to raise_error(RuntimeError, 'Please set env to :test or :live') }
    end

    context 'if env, api_key and company_id are set' do
      before do
        Idnow.env = :test
        Idnow.company_id = 'somecompany'
        Idnow.api_key = 'some key'
      end

      it { is_expected.to be_a(Idnow::Client) }

      it 'memoizes the client' do
        expect(Idnow::Client).to receive(:new).once.and_call_original
        2.times { Idnow.client }
      end
    end
  end
end
