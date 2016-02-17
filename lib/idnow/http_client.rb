module Idnow
  class HttpClient
    def initialize(host:)
      @uri = URI.parse(host)
    end

    def execute(request, headers = {})
      headers.each do |k, v|
        request[k] = v
      end
      begin
        client.request(request)
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
        raise Idnow::ConnectionException, e
      end
    end

    private

    def client
      Net::HTTP.new(@uri.host, @uri.port).tap do |http|
        http.use_ssl = true
      end
    end
  end
end
