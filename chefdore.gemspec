# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chefdore/version'

Gem::Specification.new do |spec|
  spec.name          = "chefdore"
  spec.version       = Chefdore::VERSION
  spec.authors       = ["Jason Barnett"]
  spec.email         = ["jason.w.barnett@gmail.com"]
  spec.summary       = %q{Chef tool that was named after Dumbledore.}
  spec.description   = %q{Chef tool that can be used to do some helpful things.}
  spec.homepage      = "https://github.com/jasonwbarnett/chefdore"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.18"
  spec.add_dependency "chef", "~> 11.10.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
