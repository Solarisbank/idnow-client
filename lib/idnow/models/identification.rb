module Idnow
  class Identification
    attr_reader :identification_process, :contact_data, :user_data,
                :identification_document, :attachments

    def initialize(data)
      @identification_process = data['identificationprocess']
      @contact_data = data['contactdata']
      @user_data = data['userdata']
      @identification_document = data['identification_document']
      @attachments = data['attachments']
    end
  end
end
