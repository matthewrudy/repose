# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "repose"
  s.version = "0.0.1.alpha1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Rudy Jacobs"]
  s.date = "2011-12-14"
  s.email = "MatthewRudyJacobs@gmail.com"
  s.executables = ["repose"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["Gemfile", "Rakefile", "README.rdoc", "repose.rdoc", "bin/repose", "test/repose_test.rb", "test/test_helper.rb", "lib/repose/definition.rb", "lib/repose/dsl.rb", "lib/repose/generator/Reposefile", "lib/repose/generator.rb", "lib/repose/version.rb", "lib/repose.rb"]
  s.homepage = "https://github.com/matthewrudy/repose"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Synchronise your repositories"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gli>, ["~> 0.1.0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<gli>, ["~> 0.1.0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<gli>, ["~> 0.1.0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end
