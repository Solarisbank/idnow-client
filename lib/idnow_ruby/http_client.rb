module IdnowRuby
  class HttpClient
    def initialize(host:, api_key:)
      @uri = URI.parse(host)
      @api_key = api_key
    end

    def execute(request)
      request['X-API-KEY'] = @api_key
      client.request(request)
    end

    private

    def client
      Net::HTTP.new(@uri.host, @uri.port).tap do |http|
        http.use_ssl = true
      end
    end
  end
end
