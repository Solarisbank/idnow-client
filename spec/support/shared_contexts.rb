# frozen_string_literal: true

RSpec.shared_context 'stub external soap client calls', :stub_connect do
  let(:client) { Idnow::Client.new(env: env, company_id: company_id, api_key: api_key) }
  let(:env) { :test }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }

  def idnow_url(path, host: nil)
    host ||= client.host
    File.join("#{host}/api/v1/#{company_id}", path)
  end

  let(:login) do
    stub_request(:post, "#{client.host}/api/v1/#{company_id}/login")
      .with(body: '{"apiKey":"api_key"}')
      .to_return(status: 200, body: '{ "authToken": "nekoThtua"}', headers: {})
    client.login
  end
end
