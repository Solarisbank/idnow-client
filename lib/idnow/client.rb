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

    API_VERSION = 'v1'.freeze

    def initialize(host:, company_id:, api_key:)
      @http_client = HttpClient.new(host: host)
      @sftp_client = SftpClient.new(host: host, username: company_id, password: api_key)
      @company_id = company_id
      @api_key = api_key
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
        fail Idnow::ResponseException, r.errors if r.errors?
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
