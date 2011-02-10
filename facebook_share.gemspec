# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "facebook_share/version"

Gem::Specification.new do |s|
  s.name        = "facebook_share"
  s.version     = FacebookShare::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mike Połtyn"]
  s.email       = ["mike@poltyn.com"]
  s.homepage    = "http://github.com/Holek/facebook_share"
  s.summary = %q{A Facebook Share button for convenient re-usage}
  s.description = %q{A Facebook Share button for convenient re-usage}

  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
