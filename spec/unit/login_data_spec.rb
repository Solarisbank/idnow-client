require 'spec_helper'

describe IdnowRuby::LoginData do
  let(:login_data) { IdnowRuby::LoginData.new(api_key) }
  let(:api_key) { '12445' }

  describe '#to_json' do
    subject { login_data.to_json }

    it { is_expected.to eq "{\"apiKey\":\"#{api_key}\"}" }
  end
end
