require 'forwardable'
require 'pry'
module Idnow
  class Identification
    extend Forwardable
    include Idnow::Jsonable

    attr_accessor :identification_process, :contact_data, :user_data,
                  :identification_document, :attachments, :esigning, :raw_data

    def initialize(data)
      @identification_process  = IdentificationProcess.new(data['identificationprocess'])
      @contact_data            = ContactData.new(data['contactdata'])
      @user_data               = UserData.new(data['userdata'])
      @identification_document = IdentificationDocument.new(data.fetch('identificationdocument', {}))
      @attachments             = data['attachments']
      @esigning                = data['esigning']
      @raw_data                = data
    end

    def esigning?
      !@esigning.nil?
    end
    def_delegators :identification_process, :successful?, :result, :reason, :id, :transaction_number, :review_pending?
  end
end
