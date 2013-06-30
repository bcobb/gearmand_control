# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gearmand_control/version'

Gem::Specification.new do |spec|
  spec.name          = "gearmand_control"
  spec.version       = GearmandControl::VERSION
  spec.authors       = ["Brian"]
  spec.email         = ["bcobb@uwalumni.com"]
  spec.description   = "Ruby wrapper around running gearmand"
  spec.summary       = "Control gearmand with Ruby"
  spec.homepage      = "http://github.com/bcobb/gearmand_control"
  spec.files         = Dir['{lib/**/*}'] + %w(README.markdown)
  spec.test_files    = Dir['spec/**/*_spec.rb']
  spec.require_path  = "lib"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec"
end
