module Idnow
  class IdentificationRequest
    attr_accessor :id, :transaction_number

    def initialize(data, transaction_number, target_host, company_id)
      @id = data['id']
      @transaction_number = transaction_number
      @target_host = target_host
      @company_id = company_id
    end

    def redirect_url
      "#{@target_host}/#{@company_id}/identifications/#{@transaction_number}/identification/start"
    end
  end
end
