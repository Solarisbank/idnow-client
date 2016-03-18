module Idnow
  module API
    module UploadSignedDocuments
      def upload_document(transaction_number, document_definition_identifier, file)
        fail Idnow::InvalidArguments, 'File type must be or inherit from IO' unless file.class < IO
        fail Idnow::AuthenticationException if @auth_token.nil?
        binary_data = File.read(file).unpack('b*').first
        path = full_path_for("identifications/#{transaction_number}/documents/#{document_definition_identifier}/data")
        request = Idnow::PostBinaryRequest.new(path, binary_data)
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end
    end
  end
end
