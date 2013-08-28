module Allotment
  module Methods
    def record_event name = 'unnamed', &block
      Allotment.record_event name, &block
    end
  end
end