module Idnow
  module API
    module UploadDocuments
      def upload_identification_document(transaction_number, document_definition_identifier, file)
        fail Idnow::InvalidArguments, 'File type must be or inherit from IO' unless file.class < IO
        fail Idnow::AuthenticationException if @auth_token.nil?
        file_data = File.read(file)
        path = full_path_for("identifications/#{transaction_number}/documents/#{document_definition_identifier}/data")
        request = Idnow::PostBinaryRequest.new(path, file_data)
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end

      def upload_default_document(document_definition_identifier, file)
        fail Idnow::InvalidArguments, 'File type must be or inherit from IO' unless file.class < IO
        fail Idnow::AuthenticationException if @auth_token.nil?
        file_data = File.read(file)
        path = full_path_for("documentdefinitions/#{document_definition_identifier}/data")
        request = Idnow::PostBinaryRequest.new(path, file_data)
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end
    end
  end
end
