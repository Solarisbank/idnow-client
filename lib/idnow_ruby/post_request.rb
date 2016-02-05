# require 'json'
require 'net/http'

module IdnowRuby
  class PostRequest < Net::HTTP::Post
    def initialize(path, identification_data)
      super(path)
      self['Content-Type'] = 'application/json'
      self.body = identification_data.to_json
    end
  end
end
