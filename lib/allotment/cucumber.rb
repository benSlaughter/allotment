require 'allotment'

Before do |scenario|
	Allotment.start_recording scenario.title
end

After do |scenario|
	Allotment.stop_recording scenario.title
end

at_exit do
	Allotment.results.each do | name, values |
		puts name.to_s + ":" + value.to_s
	end
end