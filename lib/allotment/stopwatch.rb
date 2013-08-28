module Allotment
	class Stopwatch
		attr_reader :name, :status, :start_time

		def initialize name = self.class.uniqe_name
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

		private
		def self.uniqe_name
			"stopwatch_" + (@id ? @id += 1 : @id = 0).to_s
		end
	end
end
