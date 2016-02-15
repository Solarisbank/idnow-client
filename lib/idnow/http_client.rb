module Idnow
  class HttpClient
    attr_reader :api_key

    def initialize(host:, api_key:)
      @uri = URI.parse(host)
      @api_key = api_key
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
