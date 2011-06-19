# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "oa-webiso"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marshall Roch"]
  s.email       = ["marshall@mroch.com"]
  s.homepage    = "http://rubygems.org/gems/oa-webiso"
  s.summary     = %q{OmniAuth strategy for using WebISO at Carnegie Mellon}
  s.description = %q{OmniAuth strategy for using WebISO at Carnegie Mellon}

  s.rubyforge_project = "oa-webiso"

  s.add_dependency 'oa-core'
  s.add_dependency 'oa-env'
  s.add_dependency 'net-ldap'

  s.files         = Dir.glob("{lib}/**/*") + %w[LICENSE]
  s.require_paths = ["lib"]
end
