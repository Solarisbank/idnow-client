# frozen_string_literal: true

module Idnow
  class RawResponse
    attr_reader :raw

    def initialize(raw_response)
      @raw = raw_response.nil? ? raw_response.to_s : raw_response
    end

    # IDNow API always returns JSON-formatted errors,
    # even if a successful response is raw text
    def errors
      if valid_json?(@raw)
        json_data = JSON.parse(@raw)
        json_data['errors'] if json_data.class == Hash
      end
    end

    def errors?
      !errors.nil?
    end

    private

    def valid_json?(json)
      JSON.parse(json)
      true
    rescue JSON::ParserError
      false
    end
  end
end
