module Idnow
  module Response
    class Generic
      def initialize(raw_response)
        @data = JSON.parse(raw_response)
      end

      def errors
        @data['errors']
      end

      def errors?
        !errors.nil?
      end
    end
  end
end
