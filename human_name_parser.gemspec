# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "human_name_parser/version"

Gem::Specification.new do |s|
  s.name        = "human_name_parser"
  s.version     = HumanNameParser::VERSION
  s.authors     = ["Adam Bachman"]
  s.email       = ["adam.bachman@gmail.com"]
  s.homepage    = "https://github.com/abachman/human_name_parser"
  s.summary     = %q{Split most American names into their component parts.}
  s.description = %q{human_name_parser is intended to split names into their component parts.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
