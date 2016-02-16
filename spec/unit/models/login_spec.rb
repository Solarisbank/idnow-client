require 'spec_helper'

RSpec.describe Idnow::Login do
  let(:json_data) { Idnow::Response.new('{ "authToken": "nekoThtua" }').data }
  let(:login) { Idnow::Login.new(json_data) }

  describe '#auth_token' do
    subject { login.auth_token }
    it { is_expected.to eq "nekoThtua" }
  end
end
