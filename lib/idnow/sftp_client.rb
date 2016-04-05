require 'net/sftp'

module Idnow
  class SftpClient
    def initialize(host:, username:, password:)
      @host = URI.parse(host).host
      @username = username
      @password = password
    end

    def download(file_name)
      Net::SFTP.start(@host, @username, password: @password) do |sftp|
        fail Idnow::Exception, "Invalid path. No identification file found under #{file_name}" if sftp.dir['.', file_name].empty?
        begin
          sftp.download!(file_name)
        rescue Net::SFTP::Exception => e
          raise Idnow::ConnectionException, e
        end
      end
    end
  end
end
