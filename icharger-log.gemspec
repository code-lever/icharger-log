# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'icharger/log/version'

Gem::Specification.new do |spec|
  spec.name          = "icharger-log"
  spec.version       = ICharger::Log::VERSION
  spec.authors       = ["Nick Veys"]
  spec.email         = ["nick@codelever.com"]
  spec.description   = %q{Read and interpret iCharger log files.}
  spec.summary       = %q{iCharger log file reader}
  spec.homepage      = "http://github.com/code-lever/icharger-log"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'ci_reporter', '= 1.8.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 2.13'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-gem-adapter'
  spec.add_development_dependency 'simplecov-rcov'
end
