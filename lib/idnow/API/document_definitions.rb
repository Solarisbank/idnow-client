module Idnow
  module API
    module DocumentDefinitions
      def create_document_definition(document_data)
        fail Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for('documentdefinitions')
        request = Idnow::PostJsonRequest.new(path, document_data)
        execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
      end

      def list_document_definitions
        fail Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for('documentdefinitions')
        request = Idnow::GetRequest.new(path)
        response = execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
        response.data.map do |data|
          Idnow::DocumentDefinition.new(data)
        end
      end
    end
  end
end
