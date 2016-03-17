module Idnow
  module API
    module UploadSignedDocuments
      def upload_document(transaction_number, document_definition_identifier, file)
        raise Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for("identifications/#{transaction_number}/documents/#{document_definition_identifier}/data")
        request = Idnow::PostBinaryRequest.new(path, file)
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end
    end
  end
end
