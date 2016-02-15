module Idnow
  module Response
    class StartIdentification < Idnow::Response::Generic
      def initialize(raw_response, transaction_number)
        super(raw_response)
        @transaction_number = transaction_number
      end

      def id
        @data['id']
      end

      def redirect_url
        "#{Idnow.target_host}/#{Idnow.company_id}/identifications/#{@transaction_number}/identification/start"
      end
    end
  end
end
