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

    def redirect_url
      return nil if errors?
      IdnowRuby.test_env? ? "https://go.test.idnow.de/#{id}" : "https://go.idnow.de/#{id}"
    end
  end
end
