# frozen_string_literal: true

module Idnow
  module API
    module DocumentDefinitions
      def create_document_definition(document_data)
        raise Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for('documentdefinitions')
        request = Idnow::PostJsonRequest.new(path, document_data)
        execute(request, { 'X-API-LOGIN-TOKEN' => @auth_token })
      end

      def list_document_definitions
        raise Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for('documentdefinitions')
        request = Idnow::GetRequest.new(path)
        response = execute(request, { 'X-API-LOGIN-TOKEN' => @auth_token })
        response.data.map do |data|
          Idnow::DocumentDefinition.new(data)
        end
      end

      def list_cached_document_definitions(refresh = false)
        return @list_cached_document_definitions = list_document_definitions if refresh
        @list_cached_document_definitions ||= list_document_definitions
      end
    end
  end
end
