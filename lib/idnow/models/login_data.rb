# frozen_string_literal: true

require 'json'

module Idnow
  class LoginData
    def initialize(api_key)
      @api_key = api_key
    end

    def to_json(*_args)
      { apiKey: @api_key }.to_json
    end
  end
end
