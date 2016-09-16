module Idnow
  class HttpClient
    def initialize(host:, read_timout_sec: 30)
      @uri          = URI.parse(host)
      @read_timeout = read_timout_sec
    end

    def execute(request, headers = {})
      headers.each do |k, v|
        request[k] = v
      end

      client.request(request)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      raise Idnow::ConnectionException, e
    end

    private

    def client
      Net::HTTP.new(@uri.host, @uri.port).tap do |http|
        http.read_timeout = @read_timeout
        http.use_ssl      = true
      end
    end
  end
end
