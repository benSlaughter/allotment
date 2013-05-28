require 'allotment/stopwatch'

module Allotment
	class << self
		def record_event name = Time.now.to_s, &block
			start_recording name
			yield
			stop_recording name
		end

		def start_recording name = Time.now.to_s
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
	end
end
