Gem::Specification.new do |s|
  s.name        = 'allotment'
  s.version     = '0.0.1'
  s.date        = '2013-04-18'
  s.summary     = 'Allotment - performance recording'
  s.description = 'A gem for recording performance and timings of blocks or from point to point'
  s.author      = 'Ben Slaughter'
  s.email       = 'b.p.slaughter@gmail.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/benslaughter/allotment'

  s.required_ruby_version = ">= 1.9.2"
  s.add_development_dependency 'rspec'

  s.files       = ["lib/allotment.rb"]
  s.test_files  = ["spec/allotment_spec.rb"]
end