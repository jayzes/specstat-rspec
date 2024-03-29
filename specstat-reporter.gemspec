# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'specstat/reporter/version'

Gem::Specification.new do |spec|
  spec.name          = "specstat-rspec"
  spec.version       = Specstat::Reporter::VERSION
  spec.authors       = ["Jay Zeschin"]
  spec.email         = ["jay@zeschin.org"]

  spec.summary       = %q{Rspec reporter for the Specstat service}
  spec.homepage      = "https://github.com/jayzes/specstat-rspec"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec", ">= 3.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "sinatra"
end
