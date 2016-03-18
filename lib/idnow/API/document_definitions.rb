module Idnow
  module API
    module DocumentDefinitions
      def create_document_definition(document_data)
        fail Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for('documentdefinitions')
        request = Idnow::PostRequest.new(path, document_data)
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end
    end
  end
end
