# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'idnow/version'

Gem::Specification.new do |spec|
  spec.name          = 'idnow'
  spec.version       = Idnow::VERSION
  spec.authors       = ['Dominic Breuker, Joan Martinez']
  spec.email         = ['joan.martinez@hitfoxgroup']

  spec.summary       = 'Ruby client for the IDnow API'
  spec.description   = 'Library to consume the IDnow API in Ruby, http://www.idnow.eu/developers'
  spec.homepage      = 'http://example.com'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = 'http://mygemserver.com'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'net-sftp', '~>2.1'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'rubocop', '~> 0.36.0'
  spec.add_development_dependency 'factory_girl', '~> 4.5'
end
