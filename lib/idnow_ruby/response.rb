require 'json'

module IdnowRuby
  class Response


    def initialize(raw_response, transaction_number)
      @data = JSON.parse(raw_response)
      @transaction_number = transaction_number
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
      "#{IdnowRuby.target_host}/#{IdnowRuby.company_id}/identifications/#{@transaction_number}"
    end
  end
end
