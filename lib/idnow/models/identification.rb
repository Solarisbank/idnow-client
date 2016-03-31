require 'forwardable'
module Idnow
  class Identification
    extend Forwardable
    include Idnow::Jsonable

    attr_accessor :identification_process, :contact_data, :user_data,
                  :identification_document, :attachments, :esigning

    def initialize(data)
      @identification_process  = IdentificationProcess.new(data['identificationprocess'])
      @contact_data            = ContactData.new(data['contactdata'])
      @user_data               = UserData.new(data['userdata'])
      @identification_document = data['identificationdocument']
      @attachments             = data['attachments']
      @esigning                = data['esigning']
    end

    def esigning?
      !@esigning.nil?
    end
    def_delegators :identification_process, :successful?, :result, :reason, :id, :transaction_number
  end
end
