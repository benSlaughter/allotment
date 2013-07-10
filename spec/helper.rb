require 'coveralls'
Coveralls.wear!

require 'allotment'

RSpec.configure do |config|
  config.color_enabled  = true
  config.formatter      = :documentation
end
