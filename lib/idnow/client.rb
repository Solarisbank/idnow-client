module Idnow
  class Client
    API_VERSION = 'v1'.freeze
    IDENTIFICATION_STATUSES = %w(pending failed).freeze

    def initialize(host:, company_id:, api_key:)
      @http_client = HttpClient.new(host: host, api_key: api_key)
      @company_id = company_id
    end

    def request_identification(transaction_number, identification_data)
      path = full_path_for("identifications/#{transaction_number}/start")
      request = Idnow::PostRequest.new(path, identification_data)
      response = @http_client.execute(request, 'X-API-KEY' => @http_client.api_key)
      Idnow::Response::StartIdentification.new(response.body, transaction_number).tap do |r|
        raise Idnow::ResponseException, r.errors if r.errors?
      end
    end

    def login
      path = full_path_for('login')
      login_data = Idnow::LoginData.new(@http_client.api_key)
      request = Idnow::PostRequest.new(path, login_data)
      response = @http_client.execute(request)
      @auth_token = Idnow::Response::Login.new(response.body).tap do |r|
        raise Idnow::ResponseException, r.errors if r.errors?
      end.auth_token
    end

    def list_identifications(status: nil)
      raise Idnow::AuthenticationException if @auth_token.nil?
      unless status.nil? || IDENTIFICATION_STATUSES.include?(status)
        raise Idnow::InvalidArguments, "Status #{status} not defined, possible options are: #{IDENTIFICATION_STATUSES.join(',')}"
      end
      partial_path = status.nil? ? 'identifications' : "identifications?#{status}=true"
      path = full_path_for(partial_path)
      request = Idnow::GetRequest.new(path)
      response = @http_client.execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      Idnow::Response::Identifications.new(response.body).tap do |r|
        raise Idnow::ResponseException, r.errors if r.errors?
      end
    end

    private

    def full_path_for(partial_path)
      File.join('/api', API_VERSION, @company_id, partial_path)
    end
  end
end
