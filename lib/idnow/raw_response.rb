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
        json_data['errors']
      end
    end

    def errors?
      !errors.nil?
    end

    private

    def valid_json?(json)
      JSON.parse(json)
      return true
    rescue JSON::ParserError
      return false
    end
  end
end
