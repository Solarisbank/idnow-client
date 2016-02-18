require 'net/sftp'

module Idnow
  class SftpClient
    def initialize(host:, username:, password:)
      @host = URI.parse(host).host
      @username = username
      @password = password
    end

    def download(path)
      Net::SFTP.start(@host, @username, password: @password) do |sftp|
        begin
          data = sftp.download!(path)
          File.open(path, 'w') { |f| f.write(data) }
        rescue Net::SFTP::Exception => e
          raise Idnow::ConnectionException, e
        end
      end
    end
  end
end
