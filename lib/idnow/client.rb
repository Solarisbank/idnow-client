module Idnow
  class Client
    include Idnow::API::RetrieveIdentifications
    include Idnow::API::RequestIdentifications
    include Idnow::API::Logging

    API_VERSION = 'v1'.freeze

    def initialize(host:, company_id:, api_key:)
      @http_client = HttpClient.new(host: host)
      @company_id = company_id
      @api_key = api_key
    end

    private

    def execute(request, headers = {})
      http_response = @http_client.execute(request, headers)
      Idnow::Response.new(http_response.body).tap do |r|
        raise Idnow::ResponseException, r.errors if r.errors?
      end
    end

    def full_path_for(partial_path)
      File.join('/api', API_VERSION, @company_id, partial_path)
    end
  end
end
