# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knowtify/version'

Gem::Specification.new do |spec|
  spec.name          = "knowtify"
  spec.version       = Knowtify::VERSION
  spec.authors       = ["Joshua Mckinney"]
  spec.email         = ["joshmckin@gmail.com"]
  spec.summary       = %q{Knowtify api gem}
  spec.description   = %q{Knowtify api gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "excon"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-autotest"
  spec.add_development_dependency "autotest"
end
