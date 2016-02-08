require 'json'

module IdnowRuby
  class Response
    def initialize(raw_response)
      @data = JSON.parse(raw_response)
    end

    def id
      @data['id']
    end

    def errors
      @data['errors']
    end

    def errors?
      !errors.nil?
    end
  end
end
