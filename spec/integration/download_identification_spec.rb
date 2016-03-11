require 'spec_helper'

RSpec.describe 'download identification', :stub_connect do
  subject { client.download_identification(transaction_number: transaction_number) }

  let(:transaction_number) { '1' }

  before do
    sftp_client_double = double('sftp_client')
    allow(sftp_client_double).to receive(:download).with("#{transaction_number}.zip").and_return('FILE.zip')
    client.instance_variable_set(:@sftp_client, sftp_client_double)
  end

  it 'downloades a zip file' do
    is_expected.to eq('FILE.zip')
  end
end
