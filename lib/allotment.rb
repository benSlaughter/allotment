require 'json'
require 'hashie'

require 'allotment/array'
require 'allotment/stopwatch'

module Allotment
  class << self
    def on_start(&block)
      block_given? ? @on_start = block : @on_start
    end

    def on_stop(&block)
      block_given? ? @on_stop = block : @on_stop
    end

    def record_event name = 'unnamed', &block
      start_recording name
      begin
        yield
      ensure
        time = stop_recording name
      end
      return time
    end

    def start_recording name = 'unnamed'
      @watches ||= Hashie::Mash.new
      @watches[name] = Stopwatch.new name
    end

    def stop_recording name
      watch = @watches.delete(name) { |n| raise NameError, "No recording:" + n }
      result = watch.stop

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
