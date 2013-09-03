require 'allotment'

Before do |scenario|
  Allotment.start_recording scenario.title
end

After do |scenario|
  Allotment.stop_recording scenario.title
end

at_exit do
  puts Allotment.results_string
end