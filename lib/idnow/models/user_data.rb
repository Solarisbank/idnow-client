module Idnow
  class UserData
    include Idnow::Jsonable

    attr_accessor :birthday, :birthname, :birthplace, :city, :country, :firstname, :gender, :lastname, :nationality, :street, :streetnumber,
                  :title, :zipcode

    def initialize(data)
      @birthday     = dig_value('birthday', data)
      @birthname    = dig_value('birthname', data)
      @birthplace   = dig_value('birthplace', data)
      @city         = dig_value('address', 'city', data)
      @country      = dig_value('address', 'country', data)
      @firstname    = dig_value('firstname', data)
      @gender       = dig_value('gender', data)
      @lastname     = dig_value('lastname', data)
      @nationality  = dig_value('nationality', data)
      @street       = dig_value('address', 'street', data)
      @streetnumber = dig_value('address', 'streetnumber', data)
      @title        = dig_value('title', data)
      @zipcode      = dig_value('address', 'zipcode', data)
      @raw_data     = data
    end

    def address
      "#{street} #{streetnumber}, #{zipcode} #{city}, #{country}"
    end

    def address_changed?
      @raw_data['address'].values.any? { |field| field['status'] == 'CHANGE' }
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
