# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'starlight_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = "starlight_helpers"
  spec.version       = StarlightHelpers::VERSION
  spec.authors       = ["Ivan Stana"]
  spec.email         = ["stiipa@centrum.sk"]
  spec.summary       = %q{Helper modules for building websites. Flash, content, locale and model.}
  spec.description   = %q{Helper modules for building websites. Relax and use often used methods in flash, content, locale and model areas. Used and tests available.}
  spec.homepage      = "http://github.com/istana/starlight_helpers"
  spec.license       = "MIT"
  spec.post_install_message = "'Enjoy starlight helpers!'"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack", "~> 4.1"
  spec.add_dependency "redcarpet"
  spec.add_dependency "RedCloth"
  spec.add_dependency "rack", "~> 1.5"
  spec.add_dependency "actionview", "~> 4.1"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
