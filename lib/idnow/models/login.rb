module Idnow
  class Login
    attr_reader :auth_token
    def initialize(data)
      @auth_token = data['authToken']
    end
  end
end
