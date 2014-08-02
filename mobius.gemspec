$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mobius/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mobius"
  s.version     = Mobius::VERSION
  s.authors     = ["Alex Neth"]
  s.email       = ["alex@crystalneth.com"]
  s.homepage    = ""
  s.summary     = "Integration library for Mobius Payments."
  s.description = "Integration library for Mobius Payments."

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "faraday_middleware"
  s.add_dependency "multi_xml"

  # s.add_development_dependency "sqlite3"
end
