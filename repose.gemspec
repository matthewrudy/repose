# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','repose_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'repose'
  s.version = Repose::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/repose
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','repose.rdoc']
  s.rdoc_options << '--title' << 'repose' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'repose'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
end
