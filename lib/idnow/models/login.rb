# frozen_string_literal: true

module Idnow
  class Login
    attr_accessor :auth_token

    def initialize(data)
      @auth_token = data['authToken']
    end
  end
end
