require 'net/http'

module Idnow
  class GetRequest < Net::HTTP::Get
    def initialize(path, content_type = 'application/json')
      super(path)
      self['Content-Type'] = content_type
    end
  end
end
