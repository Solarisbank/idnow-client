require 'net/http'

module Idnow
  class GetRequest < Net::HTTP::Get
    def initialize(path)
      super(path)
      self['Content-Type'] = 'application/json'
    end
  end
end
