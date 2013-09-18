require 'json'
require 'hashie'

require 'allotment/array'
require 'allotment/stopwatch'

# Allotment
# "Time is what we want most, but what we use worst."
#
# require 'allotment'
#
# Allotment.record 'my_event' do
#   # code here
# end
#
# Allotment.start 'my_event'
# # code here
# Allotment.stop 'my_event'
#
module Allotment
  @watches = Hashie::Mash.new
  @results = Hashie::Mash.new

  # Allotment module methods
  class << self
    # Called when a recording is started
    # @return [Proc] the stored request proc
    #
    def on_start &block
      block_given? ? @on_start = block : @on_start
    end

    # Called when a recording is stopped
    # @return [Proc] the stored request proc
    #
    def on_stop &block
      block_given? ? @on_stop = block : @on_stop
    end

    # Start recording
    # @param name [String] the name of the event
    #
    def start name = 'unnamed_recording'
      on_start.call if on_start
      @watches[name] = Stopwatch.new(name).start
    end

    # Stop recording
    # @param name [String] the name of the event
    # @raise [NameError] if the recording does not exist
    #
    def stop name
      result = @watches.delete(name){ |n| raise NameError, "Unknown recording:" + n }.stop
      on_stop.call if on_stop

      # Dealing with the results
      @results[name] ||= Array.new
      @results[name] << result
      return result
    end

    # Record event
    # Expects a block to be passed
    # @param name [String] the name of the event
    # @yield [] runs the event
    #
    def record name = 'unnamed_event'
      start name
      begin
        yield
      ensure
        result = stop name
      end
      result
    end

    # Results at that present moment
    # @return [Hashie::Mash] the  current results
    #
    def results
      @results
    end
  end
end
