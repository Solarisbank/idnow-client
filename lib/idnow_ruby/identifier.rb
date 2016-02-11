module IdnowRuby
  class Identifier
    API_VERSION = 'v1'.freeze

    def initialize(host:, company_id:, api_key:)
      @http_client = HttpClient.new(host: host, api_key: api_key)
      @company_id = company_id
    end

    def start(transaction_number, identification_data)
      path = path(transaction_number)
      request = IdnowRuby::PostRequest.new(path, identification_data)
      response = @http_client.execute(request)
      IdnowRuby::Response.new(response.body, transaction_number).tap do |r|
        fail IdnowRuby::ResponseException, r.errors if r.errors?
      end
    end

    private

    def path(transaction_number)
      File.join('/api', API_VERSION, @company_id, 'identifications', transaction_number.to_s, 'start')
    end
  end
end
