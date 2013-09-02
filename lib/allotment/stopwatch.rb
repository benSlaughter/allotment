class Allotment
	class Stopwatch
		attr_reader :name, :status

		def initialize name = nil
			@stopwatch  = self.class.uniqe_name
			@name       = name || @stopwatch
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
			@current_time = nil
		end

		def lap
			@new_lap = Time.now - (@lap_time || @start_time)
			@lap_time = Time.now
			return @new_lap
		end

		def split
			Time.now - @start_time
		end

		private
		def self.uniqe_name
			"stopwatch_" + (@id ? @id += 1 : @id = 0).to_s
		end
	end
end
