# frozen_string_literal: true

module Idnow
  class Configuration
    # TODO: This class is not being used right now, but its aim is to be able for the developers
    # using the gem to set its configuration with something like
    # Idnow.config do |config|
    # config.url = Idnow::TEST_SERVER
    # config.env = :test
    # config.company_id = company_id
    # end

    attr_accessor :api_key, :company_id, :host, :api_version

    module Idnow
      module Host
        TEST = 'https://gateway.test.idnow.de'
        PRODUCTION = 'https://gateway.idnow.de'
      end
    end
  end
end
