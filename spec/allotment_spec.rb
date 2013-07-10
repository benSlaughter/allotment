require 'helper'

describe Allotment do
  it "is a module" do
    Allotment.class.should eq Module
  end

  describe ".record_event" do
    it "records the time for the block" do
      Allotment.record_event('name') { nil }
    end

    it "returns a float" do
      result = Allotment.record_event('name') { nil }
      result.class.should eq Float
    end

    it "returns the execute time of the block" do
      result = Allotment.record_event('name') { sleep 0.01 }
      result.round(2).should eq 0.01
    end
  end

  describe ".start_recording" do
    it "returns a stopwatch instance" do
      result = Allotment.start_recording
      result.class.should eq Allotment::Stopwatch
    end

    it "returns a stopwatch with the given name" do
      result = Allotment.start_recording 'my_recording'
      result.name.should eq 'my_recording'
    end

    it "returns a stopwatch that is 'running'" do
      result = Allotment.start_recording
      result.status.should eq 'running'
    end
  end

  describe ".stop_recording" do
    it "returns a float" do
      Allotment.start_recording 'my_recording1'
      result = Allotment.stop_recording 'my_recording1'
      result.class.should eq Float
    end

    it "returns the execute time of the code" do
      Allotment.start_recording 'my_recording2'
      sleep 0.01
      result = Allotment.stop_recording 'my_recording2'
      result.round(2).should eq 0.01
    end

    it "raises an error if the recording does not exist" do
      expect { Allotment.stop_recording 'my_recording3' }.to raise_error NameError, "No recording:my_recording3"
    end
  end

  describe ".results" do
    it "returns a hash" do
      Allotment.record_event('my_recording4') { nil }
      Allotment.results.class.should eq Hash
    end

    it "returns a hash with the event in" do
      Allotment.record_event('my_recording5') { nil }
      Allotment.results.should include('my_recording5')
    end

    it "stores the result under the event" do
      Allotment.record_event('my_recording6') { sleep 0.01 }
      Allotment.results['my_recording6'][0].round(2).should eq 0.01
    end

    it "stores each result of each event" do
      Allotment.record_event('my_recording7') { sleep 0.01 }
      Allotment.record_event('my_recording7') { sleep 0.02 }
      Allotment.results['my_recording7'][0].round(2).should eq 0.01
      Allotment.results['my_recording7'][1].round(2).should eq 0.02
    end
  end
end