module Idnow
  class ContactData
    attr_accessor :mobilephone, :email

    def initialize(data)
      @mobilephone = data['mobilephone']
      @email = data['email']
    end
  end
end
