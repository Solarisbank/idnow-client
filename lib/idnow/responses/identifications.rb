module Idnow
  module Response
    class Identifications < Idnow::Response::Generic
      def identifications
        @data['identifications']
      end
    end
  end
end
