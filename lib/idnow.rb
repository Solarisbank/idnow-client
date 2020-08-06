# frozen_string_literal: true

require 'idnow/modules/jsonable'
require 'idnow/client'

require 'idnow/http_client'
require 'idnow/sftp_client'
require 'idnow/post_json_request'
require 'idnow/post_binary_request'
require 'idnow/get_request'
require 'idnow/raw_response'
require 'idnow/json_response'
require 'idnow/exception'

require 'idnow/models/login'
require 'idnow/models/identification_request'
require 'idnow/models/identification'
require 'idnow/models/identification_process'

require 'idnow/models/user_data'
require 'idnow/models/contact_data'
require 'idnow/models/identification_data'
require 'idnow/models/identification_document'
require 'idnow/models/login_data'
require 'idnow/models/document_definition'

module Idnow
  # Used to request an identification through the idnow API
  module Host
    TEST_SERVER = 'https://gateway.test.idnow.de'
    LIVE_SERVER = 'https://gateway.idnow.de'
  end

  # Used for redirecting the user to the identification process
  module TargetHost
    TEST_SERVER = 'https://go.test.idnow.de'
    LIVE_SERVER = 'https://go.idnow.de'
  end

  ENVIRONMENTS = {
    test: {
      host: Host::TEST_SERVER,
      target_host: TargetHost::TEST_SERVER
    },
    live: {
      host: Host::LIVE_SERVER,
      target_host: TargetHost::LIVE_SERVER
    }
  }.freeze

  def env=(env)
    raise ArgumentError, 'Please provide a valid enviroment, :test or :live' unless ENVIRONMENTS.keys.include?(env)
    @client = nil
    @env = env
  end

  def company_id=(company_id)
    @client = nil
    @company_id = company_id
  end

  def api_key=(api_key)
    @client = nil
    @api_key = api_key
  end

  def sftp_options=(sftp_options)
    @client = nil
    @sftp_options = sftp_options
  end

  def custom_environments=(custom_environments)
    @client = nil
    @custom_environments = custom_environments
  end

  def endpoint(env, host)
    (@custom_environments || {}).dig(env, host) || Idnow::ENVIRONMENTS[env][host]
  end

  def client
    @client ||= Idnow::Client.new(env: @env, company_id: @company_id, api_key: @api_key, sftp_options: @sftp_options || {})
  end

  module_function :env=, :company_id=, :api_key=, :sftp_options=, :custom_environments=, :endpoint, :client
end
