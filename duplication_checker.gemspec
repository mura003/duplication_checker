# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duplication_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "duplication_checker"
  spec.version       = DuplicationChecker::VERSION
  spec.authors       = ["N.Murakami"]
  spec.email         = ["murakami.naohiro@synergy101.jp"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "activesupport"

  spec.add_runtime_dependency 'activerecord'
  spec.add_runtime_dependency "activesupport"
end
