# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'idnow'
  spec.version       = '2.4.1'
  spec.authors       = ['Joan Martinez, Tobias Bielohlawek']
  spec.email         = ['developers@solarisbank.de']

  spec.summary       = 'Ruby client for the IDnow API'
  spec.description   = 'Library to consume the IDnow API in Ruby, http://www.idnow.eu/developers'

  spec.homepage      = 'https://github.com/solarisBank/idnow-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.metadata = {
    "github_repo" => "ssh://github.com/Solarisbank/idnow-client"
  }

  spec.required_ruby_version = '>= 2.7'

  spec.add_runtime_dependency 'net-sftp', '~>2.1'

  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
