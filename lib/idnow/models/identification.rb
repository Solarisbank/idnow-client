require 'forwardable'
module Idnow
  class Identification
    include Idnow::Jsonable

    extend Forwardable

    attr_accessor :identification_process, :contact_data, :user_data,
                  :identification_document, :attachments

    def initialize(data)
      @identification_process = IdentificationProcess.new(data['identificationprocess'])
      @contact_data = ContactData.new(data['contactdata'])
      @user_data = UserData.new(data['userdata'])
      @identification_document = data['identification_document']
      @attachments = data['attachments']
    end

    def_delegators :identification_process, :successful?, :result, :reason, :id, :transaction_number
  end
end
