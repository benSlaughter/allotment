require 'allotment/stopwatch'

module Allotment
	class Stopwatch
		attr_reader :name, :status, :start_time

		def initialize name = Time.now.to_s
			@name       = name
			@status     = 'running'
			@start_time = Time.now
		end
	end
end
