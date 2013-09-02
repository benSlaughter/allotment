require 'coveralls'
Coveralls.wear!

require 'allotment'
require 'allotment/methods'

RSpec.configure do |config|
  config.color_enabled  = true
  config.formatter      = :documentation
end
