require 'spec_helper'

RSpec.describe Idnow::SftpClient do
  let(:sftp_client) { Idnow::SftpClient.new(host: host, username: username, password: password) }
  let(:host) { Idnow::Host::TEST_SERVER }
  let(:expected_sftp_host) { 'gateway.test.idnow.de' }
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:path) { '/file.zip' }

  describe '.initialize' do
    context 'when a timeout option is passed' do
      let(:sftp_client) { Idnow::SftpClient.new(host: host, username: username, password: password, timeout: 123) }

      it 'starts Net::SFTP with that timeout' do
        expect(Net::SFTP).to receive(:start)
          .with(expected_sftp_host, username, password: password, timeout: 123)

        sftp_client.download(path)
      end
    end

    context 'when no timeout option is passed' do
      let(:sftp_client) { Idnow::SftpClient.new(host: host, username: username, password: password) }

      it 'starts Net::SFTP with no timeout' do
        expect(Net::SFTP).to receive(:start)
          .with(expected_sftp_host, username, password: password)

        sftp_client.download(path)
      end
    end
  end

  describe '#download' do
    subject { sftp_client.download(path) }

    let(:sftp_double) { double('sftp') }

    before do
      allow(Net::SFTP).to receive(:start)
        .with(expected_sftp_host, username, password: password)
        .and_yield(sftp_double)
      allow(sftp_client).to receive(:file_exists).and_return file_exists
    end

    context 'when the file does not exist' do
      let(:file_exists) { false }
      it { expect { subject }.to raise_error(Idnow::Exception) }
    end

    context 'when the file exists' do
      let(:file_exists) { true }
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
