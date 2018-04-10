# frozen_string_literal: true

require 'idnow/API/authentication'
require 'idnow/API/automated_testing' # shouldn't be included by default
require 'idnow/API/request_identifications'
require 'idnow/API/retrieve_identifications'
require 'idnow/API/document_definitions'
require 'idnow/API/upload_documents'
require 'idnow/API/download_documents'

module Idnow
  class Client
    include Idnow::API::Authentication
    include Idnow::API::RetrieveIdentifications
    include Idnow::API::RequestIdentifications
    include Idnow::API::AutomatedTesting
    include Idnow::API::DocumentDefinitions
    include Idnow::API::UploadDocuments
    include Idnow::API::DownloadDocuments

    API_VERSION = 'v1'

    attr_reader :host

    def initialize(env:, company_id:, api_key:, timeout: nil)
      raise 'Please set env to :test or :live' unless Idnow::ENVIRONMENTS.keys.include?(env)
      raise 'Please set your company_id' if company_id.nil?
      raise 'Please set your api_key' if api_key.nil?
      @host        = Idnow.endpoint(env, :host)
      @target_host = Idnow.endpoint(env, :target_host)
      @company_id  = company_id
      @api_key     = api_key

      @http_client = HttpClient.new(host: @host)

      sftp_client_options = { host: @host, username: @company_id, password: @api_key }
      sftp_client_options[:timeout] = timeout if timeout
      @sftp_client = SftpClient.new(sftp_client_options)
    end

    private

    def execute(request, headers = {}, http_client: @http_client)
      http_response = http_client.execute(request, headers)

      response = if request.content_type == 'application/json'
                   Idnow::JsonResponse.new(http_response.body)
                 else
                   Idnow::RawResponse.new(http_response.body)
                 end

      response.tap do |r|
        raise Idnow::ResponseException, r.errors if r.errors?
      end
    end

    def full_path_for(partial_path)
      File.join('/api', API_VERSION, @company_id, partial_path)
    end

    def automated_testing_http_client
      @automated_testing_http_client ||= HttpClient.new(host: Idnow::API::AutomatedTesting::HOST)
    end
  end
end
