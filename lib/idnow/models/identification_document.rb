module Idnow
  class IdentificationDocument
    include Idnow::Jsonable

    attr_accessor :country, :number, :issued_by, :date_issued, :type, :valid_until
    def initialize(data)
      @country             = dig_value('country', data)
      @number              = dig_value('number', data)
      @issued_by           = dig_value('issuedby', data)
      @date_issued         = dig_value('dateissued', data)
      @type                = dig_value('type', data)
      @valid_until         = dig_value('validuntil', data)
    end

    private

    def dig_value(*keys, data)
      # TODO: use ruby 2.3 and dig
      result = data
      keys.each do |key|
        result = result.fetch(key, {})
      end
      result['value']
    end
  end
end
