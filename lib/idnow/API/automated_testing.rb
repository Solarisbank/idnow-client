module Idnow
  module API
    module AutomatedTesting
      HOST = 'https://api.test.idnow.de'.freeze

      def testing_start(transaction_number:)
        path = full_path_for("identifications/#{transaction_number}/start")
        request = Idnow::PostJsonRequest.new(path, {})
        execute(request, 'X-API_KEY' => @api_key, http_client: automated_testing_http_client)
      end

      def testing_request_video_chat(transaction_number:)
        path = full_path_for("identifications/#{transaction_number}/requestVideoChat")
        request = Idnow::PostJsonRequest.new(path, {})
        execute(request, 'X-API_KEY' => @api_key, http_client: automated_testing_http_client)
      end
    end
  end
end
