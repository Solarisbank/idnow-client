module Idnow
  class IdentificationDocument
    include Idnow::Jsonable

    attr_accessor :country, :number, :issued_by, :date_issued, :type, :valid_until
    def initialize(data)
      @country     = data.dig('country', 'value')
      @number      = data.dig('number', 'value')
      @issued_by   = data.dig('issuedby', 'value')
      @date_issued = data.dig('dateissued', 'value')
      @type        = data.dig('type', 'value')
      @valid_until = data.dig('validuntil', 'value')
    end

    def date_issued
      Date.parse(@date_issued) if @date_issued
    end

    def valid_until
      Date.parse(@valid_until) if @valid_until
    end
  end
end
