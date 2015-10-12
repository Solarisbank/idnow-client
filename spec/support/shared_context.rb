RSpec.shared_context 'configuration' do
  let(:config) { {
    company_id: 'random_company_id',
    api_key: 'random_api_key'
   } }

  before do
    IdnowRuby.configure do |configuration|
      configuration.company_id = config[:company_id]
      configuration.api_key = config[:api_key]
    end
  end
end