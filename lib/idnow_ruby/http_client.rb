module IdnowRuby
  class HttpClient
    def initialize(host:, api_key:)
      @uri = URI.parse(host)
      @api_key = api_key
    end

    def execute(request)
      request['X-API-KEY'] = @api_key
      begin
        client.request(request)
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
        raise IdnowRuby::ConnectionException, e
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
