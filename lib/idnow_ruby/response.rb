require 'json'

module IdnowRuby
  #TODO use diferent files
  class Response
    def initialize(raw_response)
      @data = JSON.parse(raw_response)
    end

    def errors
      @data['errors']
    end

    def errors?
      !errors.nil?
    end
  end

  class IdentificationResponse < Response
    def initialize(raw_response, transaction_number)
      super(raw_response)
      @transaction_number = transaction_number
    end

    def id
      @data['id']
    end

    def redirect_url
      "#{IdnowRuby.target_host}/#{IdnowRuby.company_id}/identifications/#{@transaction_number}/identification/start"
    end
  end

  class LoginResponse < Response
    def auth_token
      @data['authToken']
    end
  end
end
