require 'json'
require 'hashie'

require 'allotment/array'
require 'allotment/stopwatch'

module Allotment
  @watches = Hashie::Mash.new
  @results = Hashie::Mash.new

  class << self
    def on_start(&block)
      block_given? ? @on_start = block : @on_start
    end

    def on_stop(&block)
      block_given? ? @on_stop = block : @on_stop
    end

    def start name = 'unnamed_recording'
      on_start.call if on_start
      @watches[name] = Stopwatch.new(name).start
    end

    def stop name
      result = @watches.delete(name){ |n| raise NameError, "No recording:" + n }.stop
      on_stop.call if on_stop

      # Dealing with the results
      @results[name] ||= Array.new
      @results[name] << result
      return result
    end

    def record name = 'unnamed_event'
      start name
      begin
        yield
      ensure
        result = stop name
      end
      result
    end

    def results
      @results
    end
  end
end
