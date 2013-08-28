require 'allotment/array'
require 'allotment/stopwatch'
require 'allotment/methods'
require 'json'

module Allotment
	class << self
		def record_event name = 'unnamed', &block
			start_recording name
			yield
			stop_recording name
		end

		def start_recording name = 'unnamed'
			@watches ||= Hash.new
			@watches[name] = Stopwatch.new name
		end

		def stop_recording name
			watch = @watches.delete(name) { |n| raise NameError, "No recording:" + n }
			result = watch.stop

			# Dealing with the results
			@results ||= Hash.new
			@results[name] ||= Array.new
			@results[name].push result

			return result
		end

		def results
			@results
		end

		def results_string
			JSON.pretty_generate @results
		end
	end
end
