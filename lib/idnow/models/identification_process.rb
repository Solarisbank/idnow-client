# frozen_string_literal: true

module Idnow
  class IdentificationProcess
    include Idnow::Jsonable

    SUCCESSFUL_RESPONSES = %w[SUCCESS SUCCESS_DATA_CHANGED].freeze
    attr_accessor :result, :reason, :company_id, :filename, :agentname, :identification_time, :id, :href, :type, :transaction_number

    def initialize(data)
      @result              = data['result']
      @reason              = data['reason']
      @company_id          = data['companyid']
      @filename            = data['filename']
      @agentname           = data['agentname']
      @identification_time = data['identificationtime']
      @id                  = data['id']
      @href                = data['href']
      @type                = data['type']
      @transaction_number  = data['transactionnumber']
    end

    def successful?
      SUCCESSFUL_RESPONSES.include?(result)
    end

    def review_pending?
      result == 'REVIEW_PENDING' || result == 'FRAUD_SUSPICION_PENDING'
    end
  end
end
