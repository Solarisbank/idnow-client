module Idnow
  class ContactData
    include Idnow::Jsonable

    attr_accessor :mobilephone, :email

    def initialize(data)
      @mobilephone = data['mobilephone']
      @email = data['email']
    end
  end
end
