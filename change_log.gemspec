$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "change_log/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "change_log"
  s.version = ChangeLog::VERSION
  s.authors = ["Muntasim Ahmed"]
  s.email = ["ahmed2tul@gmail.com"]
  s.homepage = "https://github.com/amuntasim/change-log"
  s.summary = "mountable engine that parse git commits and produce github like change log"
  s.description = "mountable engine that parse git commits and produce github like change log"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "git", "~> 1.2.6"
  s.add_dependency("orm_adapter", "~> 0.1")
  s.add_dependency("kramdown", ">= 1.0.0")
  s.add_dependency("railties", ">= 3.1", "< 5")

  s.add_development_dependency "sqlite3"
end
