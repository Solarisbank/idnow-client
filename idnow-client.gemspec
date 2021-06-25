# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'idnow'
  spec.version       = '2.2.0'
  spec.authors       = ['Joan Martinez, Tobias Bielohlawek']
  spec.email         = ['joan.martinez@solarisbank.de']

  spec.summary       = 'Ruby client for the IDnow API'
  spec.description   = 'Library to consume the IDnow API in Ruby, http://www.idnow.eu/developers'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.homepage      = 'https://github.com/solarisBank/idnow-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'net-sftp', '~>2.1'

  spec.required_ruby_version = '>= 2.3', '< 3.1'

  spec.add_development_dependency 'factory_bot', '~> 4.5'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rubocop', '~> 0.54.0'
  spec.add_development_dependency 'shoulda-matchers', '~>3.1'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'webmock', '~> 1.22'
end
