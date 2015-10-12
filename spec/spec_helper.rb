$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'idnow_ruby'
require 'pry'

require 'support/shared_context.rb'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')
