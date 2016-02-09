module IdnowRuby
  class Exception < StandardError
    def initialize(e)
      super("Request to IDnow failed: #{e.class}, #{e.message}")
    end
  end
end
