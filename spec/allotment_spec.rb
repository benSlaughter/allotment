require 'helper'

describe Allotment do
  it "is a class" do
    Allotment.class.should eq Module
  end

  describe ".record_event" do
    it "records the time for the block" do
      Allotment.record_event('my_recording 0.1') { sleep 0.01 }
    end

    it "records the time for the proc" do
      Allotment.record_event 'my_recording 0.2' do
        sleep 0.01
      end
    end

    it "returns a float" do
      result = Allotment.record_event('my_recording 0.3') { sleep 0.01 }
      result.class.should eq Float
    end

    it "returns the execute time of the block" do
      result = Allotment.record_event('my_recording 0.4') { sleep 0.01 }
      result.round(2).should eq 0.01
    end

    it "returns still records the performance upon error" do
      expect { Allotment.record_event('failed_recording') { sleep 0.01; raise 'error' } }.to raise_error RuntimeError, "error"
      Allotment.results['failed_recording'].first.round(2).should eq 0.01
    end
  end

  describe ".start_recording" do
    it "returns a stopwatch instance" do
      result = Allotment.start_recording
      result.class.should eq Allotment::Stopwatch
    end

    it "returns an unnamed stopwatch if no name given" do
      result = Allotment.start_recording
      result.name.should eq 'unnamed'
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
      sleep 0.01
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

  describe ".before" do
    it "adds a hook to the before hooks array" do
      hooks = Allotment.before { nil }
      Allotment._hooks[:before].should eq hooks
    end

    it "runs the hook before the performance recording" do
      Allotment.before { @before = Time.now.to_f }
      Allotment.record_event('before') { @record = Time.now.to_f }
      @record.should be > Allotment.instance_variable_get("@before")
    end
  end

  describe ".after" do
    it "adds a hook to the after hooks array" do
      hooks = Allotment.after { nil }
      Allotment._hooks[:after].should eq hooks
    end

    it "runs the hook after the performance recording" do
      Allotment.after { @after = Time.now.to_f }
      Allotment.record_event('after') { @record = Time.now.to_f }
      @record.should be < Allotment.instance_variable_get("@after")
    end
  end

  describe ".results" do
    it "returns a hash" do
      Allotment.record_event('my_recording4') { sleep 0.01 }
      Allotment.results.class.should eq Hashie::Mash
    end

    it "returns a hash with the event in" do
      Allotment.record_event('my_recording5') { sleep 0.01 }
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

  describe ".results_string" do
    it "returns a string" do
      Allotment.record_event('my_recording8') { sleep 0.01 }
      Allotment.results_string.class.should eq String
    end

    it "returns a string with the event in" do
      Allotment.record_event('my_recording9') { sleep 0.03 }
      Allotment.results_string.should include 'my_recording9'
      Allotment.results_string.should include '0.03'
    end
  end
end