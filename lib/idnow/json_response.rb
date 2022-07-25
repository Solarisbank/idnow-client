# frozen_string_literal: true

module Idnow
  class JsonResponse < RawResponse
    attr_reader :data

    def initialize(raw_response)
      super
      raw_response = '{}' if raw_response == ''
      @data = JSON.parse(raw_response)
    end
  end
end
