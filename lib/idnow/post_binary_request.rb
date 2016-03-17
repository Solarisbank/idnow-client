require 'net/http'

module Idnow
  class PostBinaryRequest < Net::HTTP::Post
    def initialize(path, binary_data)
      super(path)
      self['Content-Type'] = 'application/octet-stream'
      self.body = binary_data
    end
  end
end
