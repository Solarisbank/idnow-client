require 'spec_helper'

describe Idnow::SftpClient do
  let(:sftp_client) { Idnow::SftpClient.new(host: host, username: username, password: password) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:path) { '/some/file.zip' }

  describe '#download' do
    subject { sftp_client.download(path) }

    context 'when a sftp exception happens' do
      before do
        sftp_double = double('sftp')
        allow(sftp_double).to receive(:download!).and_raise(Net::SFTP::Exception)
        allow(Net::SFTP).to receive(:start).and_yield(sftp_double)
      end
      it { expect { subject }.to raise_error(Idnow::ConnectionException) }
    end

    context 'when the file is successfully downloaded' do
      before do
        returned_data = 'data'
        sftp_double = double('sftp')
        file_double = double('file')
        allow(Net::SFTP).to receive(:start).and_yield(sftp_double)
        allow(sftp_double).to receive(:download!).with(path).and_return(returned_data)
        allow(File).to receive(:open).with(path, 'w').and_yield(file_double)
        allow(file_double).to receive(:write).with(returned_data).and_return('FILE')
      end

      it 'creates a file with the contents downloaded from idnow' do
        expect(subject).to eq('FILE')
      end
    end
  end
end
