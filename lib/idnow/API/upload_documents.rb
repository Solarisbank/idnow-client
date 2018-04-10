# frozen_string_literal: true

module Idnow
  module API
    module UploadDocuments
      def upload_identification_document(transaction_number, document_definition_identifier, file_data)
        request_path = full_path_for("identifications/#{transaction_number}/documents/#{document_definition_identifier}/data")
        upload_document(file_data, request_path)
      end

      def upload_default_document(document_definition_identifier, file_data)
        request_path = full_path_for("documentdefinitions/#{document_definition_identifier}/data")
        upload_document(file_data, request_path)
      end

      private

      def upload_document(file_data, request_path)
        raise Idnow::AuthenticationException if @auth_token.nil?
        request = Idnow::PostBinaryRequest.new(request_path, file_data)
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end
    end
  end
end
