require 'spec_helper'

RSpec.describe IdnowRuby::LoginResponse do
  let(:successful_raw_response) { '{ "authToken": "nekoThtua" }' }
  let(:failure_raw_response) do
    '{
                                  "errors": [{
                                          "cause": "INVALID_API_KEY"
                                  }]
                                }'
  end
  let(:login_response) { IdnowRuby::LoginResponse.new(response) }

  describe '#auth_token' do
    subject { login_response.auth_token }
    context 'given raw response without errors' do
      let(:response) { successful_raw_response }
      it 'returns the id' do
        expect(subject).to eq 'nekoThtua'
      end
    end

    context 'given a raw response with errors ' do
      let(:response) { failure_raw_response }
      it 'returns nil' do
        expect(subject).to eq nil
      end
    end
  end
end
