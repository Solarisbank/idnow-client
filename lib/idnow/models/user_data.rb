module Idnow
  class UserData
    attr_accessor :birthday, :birthname, :birthplace, :city, :country, :firstname, :gender, :lastname, :nationality, :street, :streetnumber,
                  :title, :zipcode

    def initialize(data)
      @data = data
      @birthday = dig_value('birthday')
      @birthname = dig_value('birthname')
      @birthplace = dig_value('birthplace')
      @city = dig_value('address', 'city')
      @country = dig_value('address', 'country')
      @firstname = dig_value('firstname')
      @gender = dig_value('gender')
      @lastname = dig_value('lastname')
      @nationality = dig_value('nationality')
      @street = dig_value('address', 'street')
      @streetnumber = dig_value('address', 'streetnumber')
      @title = dig_value('title')
      @zipcode = dig_value('address', 'zipcode')
    end

    def address
      "#{street} #{streetnumber}, #{zipcode} #{city}, #{country}"
    end

    private

    def dig_value(*keys)
      # TODO: use ruby 2.3 and dig
      result = @data
      keys.each do |key|
        result = result.fetch(key, {})
      end
      result['value']
    end
  end
end
