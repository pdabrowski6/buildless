# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildless/version'

Gem::Specification.new do |spec|
  spec.name          = 'buildless-app'
  spec.authors       = ['Paweł Dąbrowski']
  spec.email         = ['contact@paweldabrowski.com']
  spec.license       = 'MIT'
  spec.version       = Buildless::VERSION.dup

  spec.summary       = 'Speed up Rails app bootstraping'
  spec.description   = spec.summary
  spec.homepage      = 'https://buildless.app'
  spec.files         = Dir['README.md', 'buildless-app.gemspec', 'bin/*', 'lib/**/*']
  spec.bindir        = 'bin'
  spec.executables   = ['buildless']
  spec.require_paths = ['lib']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['changelog_uri']     = 'https://github.com/pdabrowski6/buildless/blob/master/CHANGELOG.md'
  spec.metadata['source_code_uri']   = 'https://github.com/pdabrowski6/buildless'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/pdabrowski6/buildless/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_runtime_dependency 'rest-client', '2.1.0'
  spec.add_runtime_dependency 'thor', '1.3.1'

  spec.required_ruby_version = '>= 3.2.2'
end
