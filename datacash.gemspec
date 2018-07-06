# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datacash/version'

Gem::Specification.new do |spec|
  spec.name          = "datacash"
  spec.version       = Datacash::VERSION
  spec.authors       = ["Robert Williams", "Richard Grundy"]
  spec.email         = ["rob@r-williams.com", "richguk@gmail.com"]
  spec.description   = "This library provides an idiomatic interface to the DataCash gateway."
  spec.summary       = "This library provides an idiomatic interface to the DataCash gateway."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "builder"
  spec.add_dependency "hashie", "~> 3.5.0"
  spec.add_dependency "activesupport"
  spec.add_dependency "multi_xml", "~> 0.6.0"
  spec.add_dependency "rest-client", "~> 2.0.0"
  spec.add_dependency 'gem_config'


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
