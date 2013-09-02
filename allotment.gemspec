lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'allotment/version'

Gem::Specification.new do |spec|
  spec.name         = 'allotment'
  spec.summary      = 'Allotment: Performance recording'
  spec.description  = 'Simple performance recordings of blocks, procs or point to point'
  spec.homepage     = 'http://benslaughter.github.io/allotment/'
  spec.version      = Allotment::VERSION
  spec.date         = Allotment::DATE
  spec.license      = 'MIT'

  spec.author       = 'Ben Slaughter'
  spec.email        = 'b.p.slaughter@gmail.com'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls'
  spec.add_runtime_dependency 'hashie'
  spec.add_runtime_dependency 'hooks'

  spec.files        = ['README.md', 'LICENSE.md', 'allotment.gemspec']
  spec.files        += Dir.glob("lib/**/*.rb")
  spec.files        += Dir.glob("spec/**/*")
  spec.test_files   = Dir.glob("spec/**/*")
  spec.require_path = 'lib'

end