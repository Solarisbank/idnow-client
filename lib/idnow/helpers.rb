module Idnow
  module Helpers
    PROJECT_ROOT = File.dirname(File.dirname(File.dirname(__FILE__)))

    module Factories
      Dir[File.join(PROJECT_ROOT, 'spec', 'support', 'factories', '*.rb')].each { |file| require(file) }
    end
  end
end
