module Idnow
  class IdentificationRequest
    attr_reader :id, :transaction_number

    def initialize(data, transaction_number)
      @id = data['id']
      @transaction_number = transaction_number
    end

    def redirect_url
      "#{Idnow.target_host}/#{Idnow.company_id}/identifications/#{@transaction_number}/identification/start"
    end
  end
end
