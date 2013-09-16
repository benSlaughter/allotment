module Allotment
  module Methods
    def record_event name = 'unnamed', &block
      Allotment.record_event name, &block
    end

    def start_recording name = 'unnamed'
      Allotment.start_recording name
    end

    def stop_recording name
      Allotment.stop_recording name
    end

    def results
      Allotment.results
    end

    def results_string
      Allotment.results_string
    end
  end
end