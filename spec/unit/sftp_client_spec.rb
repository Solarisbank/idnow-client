require 'spec_helper'

RSpec.describe Idnow::SftpClient do
  let(:sftp_client) { Idnow::SftpClient.new(host: host, username: username, password: password) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:path) { '/file.zip' }

  describe '#download' do
    subject { sftp_client.download(path) }

    let(:sftp_double) { double('sftp') }

    before do
      allow(Net::SFTP).to receive(:start).and_yield(sftp_double)
      allow(sftp_double).to receive_message_chain(:dir, :[]) { file_in_sftp_dir }
    end

    context 'when the file does not exist' do
      let(:file_in_sftp_dir) { [] }
      it { expect { subject }.to raise_error(Idnow::Exception) }
    end

    context 'when the file exists' do
      let(:file_in_sftp_dir) { [path] }
      context 'when a sftp exception happens' do
        before do
          allow(sftp_double).to receive(:download!).and_raise(Net::SFTP::Exception)
        end
        it { expect { subject }.to raise_error(Idnow::ConnectionException) }
      end

      context 'when the file is successfully downloaded' do
        returned_data = 'data'
        before do
          allow(sftp_double).to receive(:download!).with(path).and_return(returned_data)
        end
        it 'returns the data contents of the file ' do
          is_expected.to eq(returned_data)
        end
      end
    end
  end
end
