module Allotment
	class << self
		def record_event name = Time.now.to_s, &block
			start_time = Time.now
			yield
			Time.now - start_time
		end

		def start_recording name = Time.now.to_s
			@watches ||= Hash.new
			@watches[name] = Stopwatch.new name
			@watches[name]
		end

		def stop_recording name
			watch = @watches.delete(name) {|e| "%s does not exist!" % e }
			Time.now - watch.start_time
		end
	end

	class Stopwatch
		attr_reader :name, :status, :start_time

		def initialize name
			@name       = name
			@status     = 'running'
			@start_time = Time.now
		end
	end
end
