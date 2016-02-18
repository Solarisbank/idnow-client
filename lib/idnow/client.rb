module Idnow
  class Client
    include Idnow::API::RetrieveIdentifications
    include Idnow::API::RequestIdentifications
    include Idnow::API::Logging
    include Idnow::API::AutomatedTesting

    API_VERSION = 'v1'.freeze
    AUTOMATED_TESTING_HOST = 'https://api.test.idnow.de'.freeze

    def initialize(host:, company_id:, api_key:)
      @http_client = HttpClient.new(host: host)
      @sftp_client = SftpClient.new(host: host, username: company_id, password: api_key)
      @company_id = company_id
      @api_key = api_key
    end

    private

    def execute(request, headers = {}, http_client: @http_client)
      http_response = http_client.execute(request, headers)
      Idnow::Response.new(http_response.body).tap do |r|
        raise Idnow::ResponseException, r.errors if r.errors?
      end
    end

    def full_path_for(partial_path)
      File.join('/api', API_VERSION, @company_id, partial_path)
    end

    def automated_testing_http_client
      @automated_testing_http_client ||= HttpClient.new(host: AUTOMATED_TESTING_HOST)
    end
  end
end
