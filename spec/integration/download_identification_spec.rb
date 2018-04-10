# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'download identification', :stub_connect do
  subject { client.download_identification(transaction_number: transaction_number) }

  let(:transaction_number) { '1' }
  let(:returned_data) { 'data' }

  before do
    sftp_client_double = double('sftp_client')
    allow(sftp_client_double).to receive(:download).with("#{transaction_number}.zip").and_return(returned_data)
    client.instance_variable_set(:@sftp_client, sftp_client_double)
  end

  it 'downloades a zip file' do
    is_expected.to eq(returned_data)
  end
end
