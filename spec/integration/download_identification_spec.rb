require 'spec_helper'

RSpec.describe 'download identification', :stub_connect do
  subject { client.download_identification(transaction_number: transaction_number, destination_path: destination_path) }

  let(:transaction_number) { '1' }
  let(:destination_path) { '/some/where' }

  before do
    sftp_client_double = double('sftp_client')
    allow(sftp_client_double).to receive(:download).with(destination_path, "#{transaction_number}.zip").and_return('FILE.zip')
    client.instance_variable_set(:@sftp_client, sftp_client_double)
  end

  it 'downloades a zip file' do
    is_expected.to eq('FILE.zip')
  end
end
