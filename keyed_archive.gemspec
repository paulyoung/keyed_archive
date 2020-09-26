# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keyed_archive/version'

Gem::Specification.new do |spec|
  spec.name          = "keyed_archive"
  spec.version       = KeyedArchive::VERSION
  spec.authors       = ["Paul Young"]
  spec.email         = ["paulyoungonline@gmail.com"]
  spec.summary       = %q{A Ruby gem for working with files produced by NSKeyedArchiver.}
  spec.homepage      = "https://github.com/paulyoung/keyed_archive"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "CFPropertyList", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.9"
end
