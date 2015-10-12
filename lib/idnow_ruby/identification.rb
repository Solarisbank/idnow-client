require 'json'

module IdnowRuby
  class Identification

    attr_accessor :transaction_number, :identification_data, :response

    def self.create(transaction_number)
      new(transaction_number)
    end

    def initialize(transaction_number)
      self.transaction_number = transaction_number
    end

    def start(identification_data)
      self.identification_data = IdnowRuby::IdentificationData.new(identification_data)
      request!
    end

    def id
      response['id'] if response
    end

    def errors
      response['errors'] if response
    end

    def errors?
      !errors.nil?
    end

    private

    def request!
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request(request)

      self.response = JSON.parse(response.body) if response.body
    end

    def request
      request = Net::HTTP::Post.new(uri.request_uri)

      request["X-API-KEY"] = IdnowRuby.config.api_key
      request["Content-Type"] = 'application/json'

      request.body = identification_data.to_json

      request
    end

    def path
      @path ||= [IdnowRuby.config.host, 'api', IdnowRuby.config.api_version, IdnowRuby.config.company_id, 'identifications', transaction_number, 'start'].join('/')
    end

    def uri
      @uri ||= URI.parse(path)
    end
  end
end
