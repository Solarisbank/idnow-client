require 'idnow/version'
require 'idnow/API/request_identifications'
require 'idnow/API/retrieve_identifications'
require 'idnow/API/logging'
require 'idnow/API/automated_testing'
require 'idnow/client'
require 'idnow/http_client'
require 'idnow/sftp_client'
require 'idnow/response'
require 'idnow/models/login'
require 'idnow/models/identification_request'
require 'idnow/models/identification'
require 'idnow/post_request'
require 'idnow/get_request'
require 'idnow/identification_data'
require 'idnow/login_data'
require 'idnow/exception'

module Idnow
  extend self

  attr_reader :host, :target_host, :company_id, :api_key

  module Host # Used to request an identification through the idnow API
    TEST_SERVER = 'https://gateway.test.idnow.de'.freeze
    LIVE_SERVER = 'https://gateway.idnow.de'.freeze
  end

  module TargetHost # Used for redirecting the user to the identification process
    TEST_SERVER = 'https://go.test.idnow.de'.freeze
    LIVE_SERVER = 'https://go.idnow.de'.freeze
  end

  def env=(env)
    if env == :test
      @client = nil
      @host = Host::TEST_SERVER
      @target_host = TargetHost::TEST_SERVER
    elsif env == :live
      @client = nil
      @host = Host::LIVE_SERVER
      @target_host = TargetHost::LIVE_SERVER
    else
      raise ArgumentError, 'Please provide a valid enviroment, :test or :live'
    end
  end

  def company_id=(company_id)
    @client = nil
    @company_id = company_id
  end

  def api_key=(api_key)
    @client = nil
    @api_key = api_key
  end

  def test_env?
    raise 'Please set env to :test or :live' if host.nil?
    Idnow.host.include?('test')
  end

  def client
    raise 'Please set your company_id' if company_id.nil?
    raise 'Please set your api_key' if api_key.nil?
    raise 'Please set env to :test or :live' if host.nil?
    @client ||= Idnow::Client.new(host: host, company_id: company_id, api_key: api_key)
  end
end
