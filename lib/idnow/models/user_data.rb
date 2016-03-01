module Idnow
  class UserData
    attr_reader :birthday, :firstname, :zipcode, :country, :city, :street, :streetnumber,
                :birthplace, :nationality, :lastname

    def initialize(data)
      @birthday = data['birthday']['value']
      @firstname = data['firstname']['value']
      @zipcode = data['address']['zipcode']['value']
      @country = data['address']['country']['value']
      @city = data['address']['city']['value']
      @street = data['address']['street']['value']
      @streetnumber = data['address']['streetnumber']['value']
      @birthplace = data['birthplace']['value']
      @nationality = data['nationality']['value']
      @lastname = data['lastname']['value']
    end

    def address
      "#{street} #{streetnumber}, #{zipcode} #{city}, #{country}"
    end
  end
end
