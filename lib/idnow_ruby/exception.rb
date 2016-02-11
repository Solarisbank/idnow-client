module IdnowRuby
  class Exception < StandardError
    def initialize(message)
      super("Request to IDnow failed: #{message}")
    end
  end

  class ConnectionException < Exception
    def initialize(exception)
      super("#{exception.class}, #{exception.message}")
    end
  end

  class ResponseException < Exception
  end
end
