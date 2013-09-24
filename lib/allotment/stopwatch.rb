module Allotment
  # Stopwatch Class
  # Strangely enough works just like a stopwatch
  # @!attribute [r] name
  #   @return [String] the current name
  # @!attribute [r] status
  #   @return [String] the current status (running|stopped)
  #
  class Stopwatch
    attr_reader :name, :status

    # Overwite the obj inspect
    #
    def inspect
      "#<Stopwatch:%s>" % @status
    end

    # If the stopwatch is not given a name the uniqe_name class method is called
    # @param name [String] choosen name
    #
    def initialize name = self.class.uniqe_name
      @name    = name
      @status  = 'stopped'
      @sw_time = 0
    end

    # if the stopwatch was previously stopped
    # then the current time is removed from the current time
    # this means that it is in effect added to the total time
    # @return [Allotment::Stopwatch] self
    #
    def start
      if status == 'stopped'
        @last_start = Time.now
        @sw_start   = Time.now - @sw_time
        @status     = 'running'
      end
      self
    end

    # sets the current_time
    # this is where the start time could be Time.now - current_time
    # @return [Float] the stopwatch time
    #
    def stop
      if status == 'running'
        @status    = 'stopped'
        @last_stop = Time.now
        @sw_time   = Time.now - @sw_start
      else
        time
      end
    end

    # sets all times to 0
    # if the timer is running then the start time is just overwritten
    # if the timer is not then the start time will be over written on start
    # @return [Allotment::Stopwatch] self
    #
    def reset
      @sw_start = Time.now
      @sw_time  = 0
      self
    end

    # A lap is the amount of time from the very start or from the end of the last lap
    # Accumilated lap time is retained accross any stopages of the stopwatch
    # @return [Float] the lap time
    #
    def lap
      new_lap  = time - (@lp_start || 0)
      @lp_start = time
      new_lap
    end

    # A split is the amount of time from the last start of the stopwatch
    # it uses the sw time so it will keep accumelated time accross stoppages
    # @return [Float] the split time
    #
    def split
      @status == 'running' ? Time.now - @last_start : @last_stop - @last_start
    end

    # The accumelated current time on the stopwatch
    # @return [Float] the current time
    #
    def time
      @status == 'running' ? Time.now - @sw_start : @sw_time
    end

    private

    # ensures that if a stopwatch is unnamed it has a uniqe name
    # @return [String] stopwatch uniqe name
    def self.uniqe_name
      "stopwatch_" + (@id ? @id += 1 : @id = 0).to_s
    end
  end
end
