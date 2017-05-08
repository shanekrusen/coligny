# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coligny/version'

Gem::Specification.new do |spec|
  spec.name          = "coligny"
  spec.version       = Coligny::VERSION
  spec.authors       = ["Shane Krusen"]
  spec.email         = ["shanekrusen@gmail.com"]

  spec.summary       = %q{Implementation of Helen McKay's Coligny Calendar in Ruby'}
  spec.description   = %q{A collection of methods and classes required to construct calendars in, and convert Gregorian dates to, the Gaulish Calendar found in Coligny, France, according to Helen McKay's reconstruction.}
  spec.homepage      = "https://github.com/shanekrusen/coligny"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency "minitest"
end
