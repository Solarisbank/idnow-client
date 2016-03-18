module Idnow
  module API
    module RetrieveIdentifications
      IDENTIFICATION_STATUSES = %w(pending failed).freeze

      def list_identifications(status: nil)
        fail Idnow::AuthenticationException if @auth_token.nil?

        unless status.nil? || IDENTIFICATION_STATUSES.include?(status)
          fail Idnow::InvalidArguments, "Status #{status} not defined, possible options are: #{IDENTIFICATION_STATUSES.join(',')}"
        end
        partial_path = status.nil? ? 'identifications' : "identifications?#{status}=true"
        path = full_path_for(partial_path)
        request = Idnow::GetRequest.new(path)
        response = execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
        response.data['identifications'].map do |data|
          Idnow::Identification.new(data)
        end
      end

      def get_identification(transaction_number:)
        fail Idnow::AuthenticationException if @auth_token.nil?

        path = full_path_for("identifications/#{transaction_number}")
        request = Idnow::GetRequest.new(path)
        response = execute(request, 'X-API-LOGIN-TOKEN' => @auth_token)
        Idnow::Identification.new(response.data)
      end

      def download_identification(transaction_number:)
        path = "#{transaction_number}.zip"
        @sftp_client.download(path)
      end
    end
  end
end
