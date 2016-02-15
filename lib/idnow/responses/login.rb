module Idnow
  module Response
    class Login < Idnow::Response::Generic
      def auth_token
        @data['authToken']
      end
    end
  end
end
