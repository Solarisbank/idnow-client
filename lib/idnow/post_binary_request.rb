require 'net/http'

module Idnow
  class PostBinaryRequest < Net::HTTP::Post
    def initialize(path, data)
      super(path)
      self['Content-Type'] = 'application/octet-stream'
      self.body = data
    end
  end
end
