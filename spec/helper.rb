require 'coveralls'
require 'pry'

require 'allotment'

Coveralls.wear!

RSpec.configure do |config|
  config.color_enabled  = true
  config.formatter      = :documentation
end
