# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'errbit_fogbugz_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = "errbit_fogbugz_plugin"
  spec.version       = ErrbitFogbugzPlugin::VERSION
  spec.authors       = ["Stephen Crosby"]
  spec.email         = ["stevecrozz@gmail.com"]
  spec.description   = %q{Fogbugz integration for Errbit}
  spec.summary       = %q{Fogbugz integration for Errbit}
  spec.homepage      = "https://github.com/brandedcrate/errbit_fogbugz_plugin"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'errbit_plugin', '~> 0.4', '>= 0.4.0'
  spec.add_runtime_dependency 'ruby-fogbugz', '~> 0.1', '>= 0.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 0'
end
