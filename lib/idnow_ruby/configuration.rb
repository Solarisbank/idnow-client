module IdnowRuby
  class Configuration

    attr_accessor :api_key

    attr_accessor :company_id

    module IdnowRuby::Host
      TEST = 'https://gateway.test.idnow.de'
      PRODUCTION = 'https://gateway.idnow.de'
    end
    attr_accessor :host

    attr_accessor :api_version

    def initialize
      self.host         = IdnowRuby::Host::PRODUCTION
      self.api_version  = 'v1'
    end

  end
end