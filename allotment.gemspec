Gem::Specification.new do |spec|
  spec.name         = 'allotment'
  spec.version      = '1.0.2'

  spec.author       = 'Ben Slaughter'
  spec.email        = 'b.p.slaughter@gmail.com'
  spec.homepage     = 'http://benslaughter.github.io/allotment/'

  spec.summary      = 'Performance recording'
  spec.description  = 'A gem for recording performance and timings of blocks, procs or from point to point'
  spec.require_path = 'lib'
  spec.files        = Dir['lib/**/*.rb']
  spec.test_files   = Dir['spec/**/*.rb']
  spec.license      = 'MIT'
end