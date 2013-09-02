require 'allotment/array'
require 'allotment/stopwatch'

require 'json'
require 'hashie'
require 'hooks'

class Allotment
  include Hooks
  define_hooks :before, :after

	class << self
		def record_event name = 'unnamed', &block
			start_recording name
			yield
			stop_recording name
		end

		def start_recording name = 'unnamed'
      run_hook :before
			@watches ||= Hashie::Mash.new
			@watches[name] = Stopwatch.new name
		end

		def stop_recording name
			watch = @watches.delete(name) { |n| raise NameError, "No recording:" + n }
			result = watch.stop
      run_hook :after

			# Dealing with the results
			@results ||= Hashie::Mash.new
			@results[name] ||= Array.new
			@results[name] << result
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
