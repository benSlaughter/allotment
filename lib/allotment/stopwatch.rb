require 'allotment/stopwatch'

module Allotment
	class Stopwatch
		attr_reader :name, :status, :start_time

		def initialize name = Time.now.to_s
			@name       = name
			@status     = 'running'
			@start_time = Time.now
		end

		def start
			@start_time = Time.now - (@current_time || 0)
			@status     = 'running'
		end

		def stop
			@status       = 'stopped'
			@current_time = Time.now - @start_time
		end

		def reset
			@start_time 	= Time.now
			@current_time = 0
		end

		def lap
			Time.now - @start_time
		end
	end
end
