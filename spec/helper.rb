require 'coveralls'
require 'pry'

require 'allotment'
require 'allotment/methods'

Coveralls.wear!

RSpec.configure do |config|
  config.color_enabled  = true
  config.formatter      = :documentation
end
