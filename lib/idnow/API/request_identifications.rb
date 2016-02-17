module Idnow
  module API
    module RequestIdentifications
      def request_identification(transaction_number:, identification_data:)
        path = full_path_for("identifications/#{transaction_number}/start")
        request = Idnow::PostRequest.new(path, identification_data)
        response = execute(request, 'X-API-KEY' => @api_key)
        Idnow::IdentificationRequest.new(response.data, transaction_number)
      end
    end
  end
end
