module Idnow
  class Exception < StandardError
    def initialize(message)
      super("Request to IDnow failed: #{message}")
    end
  end

  class ConnectionException < Idnow::Exception
    def initialize(exception)
      super("#{exception.class}, #{exception.message}")
    end
  end

  class ResponseException < Idnow::Exception
  end

  class AuthenticationException < Idnow::Exception
    def initialize
      super('Not authenticaton token found, please log in first')
    end
  end

  class InvalidArguments < Idnow::Exception
  end
end
