require 'spec_helper'
require 'pry'

RSpec.describe IdnowRuby::HttpClient do
  let(:host) { 'http://www.example.com:3000' }
  let(:api_key) { 'api_key' }
  let(:http_client) { IdnowRuby::HttpClient.new(host: host, api_key: api_key) }

  describe '#new' do
    subject { http_client }
    it 'parses the host into a URI' do
      uri = subject.instance_variable_get('@uri')
      expect(uri).to be_a URI
    end
  end
end
