# frozen_string_literal: true

require 'json'

module Idnow
  class IdentificationData
    module Gender
      MALE = 'MALE'
      FEMALE = 'FEMALE'
    end

    # rubocop:disable Naming/MethodName
    attr_accessor :birthplace, :birthname, :city, :custom1,
                  :custom2, :custom3, :custom4, :custom5, :trackingid, :email, :firstname,
                  :lastname, :mobilephone, :nationality, :street, :streetnumber, :title, :zipcode,
                  :preferredLang
    # rubocop:enable Naming/MethodName

    attr_reader :country, :gender

    def initialize(params = {})
      params.each_key do |key|
        raise ArgumentError, "Attribute #{key} is not supported!" unless respond_to?(key.to_sym)

        send("#{key}=", params[key])
      end
    end

    def to_json(*_args)
      result = {}
      instance_variables.each do |attribute|
        result[attribute.to_s.delete('@')] = instance_variable_get(attribute)
      end
      result.to_json
    end

    ########### Getter / Setter ############

    def birthday
      @birthday&.strftime('%Y-%m-%d')
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
      if %w[M MALE].include?(gender.to_s.strip.upcase)
        @gender = Gender::MALE
      elsif %w[F FEMALE].include?(gender.to_s.strip.upcase)
        @gender = Gender::FEMALE
      else
        raise ArgumentError, 'Provide valid value for gender: MALE or FEMALE'
      end
    end
  end
end
