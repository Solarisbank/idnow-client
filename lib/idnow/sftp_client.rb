require 'net/sftp'

module Idnow
  class SftpClient
    def initialize(host:, username:, password:)
      @host = URI.parse(host).host
      @username = username
      @password = password
    end

    def download(destination_path, path)
      Net::SFTP.start(@host, @username, password: @password) do |sftp|
        fail Idnow::Exception, "Invalid path. No identification file found under #{path}" if sftp.dir['.', path].empty?
        begin
          data = sftp.download!(path)
          path = File.join(destination_path, path)
          File.open(path, 'w') { |f| f.write(data) }
        rescue Net::SFTP::Exception => e
          raise Idnow::ConnectionException, e
        end
      end
    end
  end
end
