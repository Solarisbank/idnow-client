# frozen_string_literal: true

require 'net/sftp'

module Idnow
  class SftpClient
    def initialize(host:, username:, password:, options: {})
      @host = URI.parse(host).host
      @username = username
      @password = password
      @options = options
    end

    def download(file_name)
      data = nil
      options = @options.merge(password: @password)
      Net::SFTP.start(@host, @username, options) do |sftp|
        raise Idnow::Exception, "Invalid path. No identification file found under #{file_name}" unless file_exists(sftp, file_name)

        begin
          data = sftp.download!(file_name)
        rescue Net::SFTP::Exception => e
          raise Idnow::ConnectionException, e
        end
      end
      data
    end

    private

    def file_exists(sftp, file_name)
      sftp.dir.entries('.').each { |entry| return true if file_name == entry.name }
      false
    end
  end
end
