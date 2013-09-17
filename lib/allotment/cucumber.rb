require 'allotment'

Before do |scenario|
  Allotment.start scenario.title
end

After do |scenario|
  Allotment.stop scenario.title
end