lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'allotment/version'

Gem::Specification.new do |spec|
  spec.name         = 'allotment'
  spec.summary      = 'Performance time recording gem'
  spec.description  = 'Recording performance simple, powerful and flexible.'
  spec.homepage     = 'http://benslaughter.github.io/allotment/'
  spec.version      = Allotment::VERSION
  spec.date         = Allotment::DATE
  spec.license      = 'MIT'

  spec.author       = 'Ben Slaughter'
  spec.email        = 'b.p.slaughter@gmail.com'

  spec.files        = ['README.md', 'License.md', 'History.md']
  spec.files        += Dir.glob("lib/**/*.rb")
  spec.files        += Dir.glob("spec/**/*")
  spec.test_files   = Dir.glob("spec/**/*")
  spec.require_path = 'lib'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls'

  spec.add_runtime_dependency 'hashie'

end