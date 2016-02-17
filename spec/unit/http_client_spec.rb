require 'spec_helper'
require 'pry'

RSpec.describe Idnow::HttpClient do
  let(:host) { 'http://www.example.com:3000' }
  let(:http_client) { Idnow::HttpClient.new(host: host) }

  describe '#new' do
    subject { http_client }
    it 'parses the host into a URI' do
      uri = subject.instance_variable_get('@uri')
      expect(uri).to be_a URI
    end
  end
end
