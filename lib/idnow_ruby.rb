require "idnow_ruby/version"

module IdnowRuby
  autoload :Identification, 'idnow_ruby/identification'
  autoload :IdentificationData, 'idnow_ruby/identification_data'
  autoload :Configuration, 'idnow_ruby/configuration'

  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= IdnowRuby::Configuration.new
    end

    alias :config :configuration
  end
end
