# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bookmark_system/version'

Gem::Specification.new do |spec|
  spec.name          = "bookmark_system"
  spec.version       = BookmarkSystem::VERSION
  spec.authors       = ["Pablo Martin Viva"]
  spec.email         = ["pmviva@gmail.com"]
  spec.summary       = %q{An active record bookmark system.}
  spec.description   = %q{An active record bookmark system developed using ruby on rails 5 applying domain driven design and test driven development principles.}
  spec.homepage      = "http://github.com/pmviva/bookmark_system"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.5")

  spec.add_dependency "rails", [ ">= 5.0", "< 6.0" ]

  spec.add_development_dependency "appraisal", "~> 2.2"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "shoulda-matchers", "~> 3.1"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "yard", "~> 0.9"
end
