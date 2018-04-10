# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'bundler/setup'
if ENV['COV']
  require 'simplecov'
  SimpleCov.start
end

require 'rspec'
require 'factory_girl'
require 'webmock/rspec'
require 'shoulda/matchers'

require 'idnow'

Dir[File.join('.', 'spec', 'support', '**', '*.rb')].each { |file| require file }
WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

FactoryGirl.register_strategy(:json, JsonStrategy)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  # Make sure we don't commit focused specs
  config.before(:example, :focus) { raise 'Dare you committing focused specs :)' } if ENV['CI']
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
