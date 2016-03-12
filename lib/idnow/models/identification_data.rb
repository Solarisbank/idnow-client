require 'json'

module Idnow
  class IdentificationData
    VALID_ATTRIBUTES = [:birthday,
                        :birthplace,
                        :birthname,
                        :city,
                        :country,
                        :custom1,
                        :custom2,
                        :custom3,
                        :custom4,
                        :custom5,
                        :trackingid,
                        :email,
                        :firstname,
                        :gender,
                        :lastname,
                        :mobilephone,
                        :nationality,
                        :street,
                        :streetnumber,
                        :title,
                        :zipcode].freeze

    module Gender
      MALE = 'MALE'.freeze
      FEMALE = 'FEMALE'.freeze
    end

    attr_accessor *VALID_ATTRIBUTES

    def initialize(params = {})
      params.keys.each do |key|
        raise ArgumentError, "Attribute #{key} is not supported!" unless VALID_ATTRIBUTES.include?(key.to_sym)

        send("#{key}=", params[key])
      end
    end

    def to_json
      result = {}
      VALID_ATTRIBUTES.each do |attribute|
        result[attribute] = send(attribute) if send(attribute)
      end
      result.to_json
    end

    ########### Getter / Setter ############

    def birthday
      @birthday.strftime('%Y-%m-%d') if @birthday
    end

    def birthday=(birthday)
      @birthday = if birthday.instance_of?(Date) || birthday.instance_of?(DateTime)
                    birthday
                  else
                    Date.parse(birthday)
                  end
    end

    def country=(country)
      raise ArgumentError, 'Country must be ISO 3166 two letter country code' unless country.instance_of?(String) && country.size == 2

      @country = country.upcase
    end

    def gender=(gender)
      if %w(M MALE).include?(gender.to_s.strip.upcase)
        @gender = Gender::MALE
      elsif %w(F FEMALE).include?(gender.to_s.strip.upcase)
        @gender = Gender::FEMALE
      else
        raise ArgumentError, 'Provide valid value for gender: MALE or FEMALE'
      end
    end
  end
end
