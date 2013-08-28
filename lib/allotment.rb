require 'allotment/array'
require 'allotment/stopwatch'
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

	def record_event name = 'unnamed', &block
    Allotment.record_event name, &block
  end

  def start_recording name = 'unnamed'
    Allotment.start_recording name
  end

  def stop_recording name
    Allotment.stop_recording name
  end

  def results
    Allotment.results
  end

  def results_string
    Allotment.results_string
  end
end
