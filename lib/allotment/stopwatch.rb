module Allotment
  class Stopwatch
    attr_reader :name, :status

    def inspect
      "#<Stopwatch:%s>" % @status
    end

    def initialize name = nil
      @name         = name || self.class.uniqe_name
      @current_time = 0
      @status       = 'stopped'
    end

    def start
      @start_time = Time.now - @current_time
      @status     = 'running'
      return self
    end

    def stop
      @status       = 'stopped'
      @current_time = Time.now - @start_time
    end

    def reset
      @start_time   = Time.now
      @current_time = 0
      self
    end

    def lap
      new_lap  = Time.now - (@lap_time || @start_time)
      @lap_time = Time.now
      return new_lap
    end

    def split
      Time.now - @start_time
    end

    def time
      @status == 'running' ? Time.now - @start_time : @current_time
    end

    private

    def self.uniqe_name
      "stopwatch_" + (@id ? @id += 1 : @id = 0).to_s
    end
  end
end
