require 'spec_helper'

describe Idnow::Client do
  let(:client) { Idnow::Client.new(host: host, company_id: company_id, api_key: api_key) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }
  let(:transaction_number) { '1' }
  describe '#download_identification' do
    subject { client.download_identification(transaction_number: transaction_number) }
    before do
      sftp_client_double = double('sftp_client')
      allow(sftp_client_double).to receive(:download).with("#{transaction_number}.zip").and_return('FILE.zip')
      client.instance_variable_set(:@sftp_client, sftp_client_double)
    end
    it 'downloades a zip file' do
      expect(subject).to eq('FILE.zip')
    end
  end
end
