module Idnow
  module API
    module DownloadDocuments
      def download_default_document(document_definition_identifier)
        fail Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for("documentdefinitions/#{document_definition_identifier}/data")
        request = Idnow::GetRequest.new(path, '')
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end
    end
  end
end
