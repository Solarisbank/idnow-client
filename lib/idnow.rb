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
require 'idnow/models/login_data'

module Idnow
  module Host # Used to request an identification through the idnow API
    TEST_SERVER = 'https://gateway.test.idnow.de'.freeze
    LIVE_SERVER = 'https://gateway.idnow.de'.freeze
  end

  module TargetHost # Used for redirecting the user to the identification process
    TEST_SERVER = 'https://go.test.idnow.de'.freeze
    LIVE_SERVER = 'https://go.idnow.de'.freeze
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
    fail ArgumentError, 'Please provide a valid enviroment, :test or :live' unless ENVIRONMENTS.keys.include?(env)
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

  # temp reader until this is into client
  def target_host
    ENVIRONMENTS[@env][:target_host]
  end

  def company_id
    @company_id
  end

  def client
    fail 'Please set your company_id' if @company_id.nil?
    fail 'Please set your api_key' if @api_key.nil?
    fail 'Please set env to :test or :live' if @env.nil?
    @client ||= Idnow::Client.new(host: ENVIRONMENTS[@env][:host], company_id: @company_id, api_key: @api_key)
  end

  module_function :env=, :company_id=, :api_key=, :client
  module_function :target_host, :company_id
end
