require 'json'

module Idnow
  class LoginData
    def initialize(api_key)
      @api_key = api_key
    end

    def to_json
      { apiKey: @api_key }.to_json
    end
  end
end
