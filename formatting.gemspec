# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "formatting/version"

Gem::Specification.new do |spec|
  spec.name          = "formatting"
  spec.version       = Formatting::VERSION
  spec.authors       = [ "Henrik Nyh", "Tomas Skogberg" ]
  spec.email         = [ "henrik@barsoom.se", "tomas@barsoom.se" ]
  spec.summary       = %q{Rails-less formatting for your unit-testable code.}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.metadata      = { "rubygems_mfa_required" => "true" }

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = [ "lib" ]

  spec.add_dependency "attr_extras"
end
