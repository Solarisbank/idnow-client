require 'idnow_ruby/version'
require 'idnow_ruby/identifier'
require 'idnow_ruby/http_client'
require 'idnow_ruby/response'
require 'idnow_ruby/post_request'
require 'idnow_ruby/identification_data'
require 'idnow_ruby/exception'

# TODO, rename to Idnow and identifier to client
module IdnowRuby
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
      @identifier = nil
      @host = Host::TEST_SERVER
      @target_host = TargetHost::TEST_SERVER
    elsif env == :live
      @identifier = nil
      @host = Host::LIVE_SERVER
      @target_host = TargetHost::LIVE_SERVER
    else
      fail ArgumentError, 'Please provide a valid enviroment, :test or :live'
    end
  end

  def company_id=(company_id)
    @identifier = nil
    @company_id = company_id
  end

  def api_key=(api_key)
    @identifier = nil
    @api_key = api_key
  end

  def test_env?
    fail 'Please set env to :test or :live' if host.nil?
    IdnowRuby.host.include?('test')
  end

  def identifier
    fail 'Please set your company_id' if company_id.nil?
    fail 'Please set your api_key' if api_key.nil?
    fail 'Please set env to :test or :live' if host.nil?
    @identifier ||= IdnowRuby::Identifier.new(host: host, company_id: company_id, api_key: api_key)
  end
end
