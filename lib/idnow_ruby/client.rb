module IdnowRuby
  class Client
    API_VERSION = 'v1'.freeze

    def initialize(host:, company_id:, api_key:)
      @http_client = HttpClient.new(host: host, api_key: api_key)
      @company_id = company_id
    end

    def request_identification(transaction_number, identification_data)
      path = request_path(transaction_number)
      request = IdnowRuby::PostRequest.new(path, identification_data)
      response = @http_client.execute(request)
      IdnowRuby::IdentificationResponse.new(response.body, transaction_number).tap do |r|
        fail IdnowRuby::ResponseException, r.errors if r.errors?
      end
    end

    def login
      login_data = IdnowRuby::LoginData.new(@http_client.api_key)
      request = IdnowRuby::PostRequest.new(login_path, login_data)
      response = @http_client.execute(request)
      IdnowRuby::LoginResponse.new(response.body).tap do |r|
        fail IdnowRuby::ResponseException, r.errors if r.errors?
      end
    end

    private

    def login_path
      File.join(base_path, 'login')
    end

    def request_path(transaction_number)
      File.join(base_path, 'identifications', transaction_number.to_s, 'start')
    end

    def base_path
      File.join('/api', API_VERSION, @company_id)
    end
  end
end
