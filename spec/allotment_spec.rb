require 'helper'

describe Allotment do
  it "is a module" do
    Allotment.class.should eq Module
  end

  describe ".on_start" do
    it "stores the passed block" do
      Allotment.on_start { 'test_returned_string' }
      Allotment.on_start.call.should eq 'test_returned_string'
    end
  end

  describe ".on_stop" do
    it "stores the passed block" do
      Allotment.on_stop { 'test_returned_string' }
      Allotment.on_stop.call.should eq 'test_returned_string'
    end
  end

  describe ".start" do
    it "returns a stopwatch instance" do
      result = Allotment.start
      result.class.should eq Allotment::Stopwatch
    end

    it "returns an unnamed stopwatch if no name given" do
      result = Allotment.start
      result.name.should eq 'unnamed_recording'
    end

    it "returns a stopwatch with the given name" do
      result = Allotment.start 'my_recording 1.1'
      result.name.should eq 'my_recording 1.1'
    end

    it "returns a stopwatch that is 'running'" do
      result = Allotment.start
      result.status.should eq 'running'
    end

    it "runs the on_start block" do
      Allotment.on_start { @start_test = 'successful' }
      @start_test.should eq nil
      Allotment.start
      @start_test.should eq 'successful'
    end
  end

  describe ".stop" do
    it "returns a float" do
      Allotment.start 'my_recording 2.1'
      sleep 0.01
      result = Allotment.stop 'my_recording 2.1'
      result.class.should eq Float
    end

    it "returns the execute time of the code" do
      Allotment.start 'my_recording 2.2'
      sleep 0.01
      result = Allotment.stop 'my_recording 2.2'
      result.round(2).should eq 0.01
    end

    it "raises an error if the recording does not exist" do
      expect { Allotment.stop 'my_recording 2.3' }.to raise_error NameError, "Unknown recording:my_recording 2.3"
    end

    it "runs the on_stop block" do
      Allotment.start 'my_recording 2.4'
      Allotment.on_stop { @stop_test = 'successful' }
      @stop_test.should eq nil
      Allotment.stop 'my_recording 2.4'
      @stop_test.should eq 'successful'
    end
  end

  describe ".record" do
    it "records the time for the block" do
      Allotment.record('my_recording 3.1') { sleep 0.01 }
    end

    it "records the time for the proc" do
      Allotment.record 'my_recording 3.2' do
        sleep 0.01
      end
    end

    it "returns a float" do
      result = Allotment.record('my_recording 3.3') { sleep 0.01 }
      result.class.should eq Float
    end

    it "returns the execute time of the block" do
      result = Allotment.record('my_recording 3.4') { sleep 0.01 }
      result.round(2).should eq 0.01
    end

    it "returns still records the performance upon error" do
      expect { Allotment.record('my_recording 3.5') { sleep 0.01; raise 'error' } }.to raise_error RuntimeError, "error"
      Allotment.results['my_recording 3.5'].first.round(2).should eq 0.01
    end
  end

  describe ".results" do
    it "returns a hash" do
      Allotment.record('my_recording 4.1') { sleep 0.01 }
      Allotment.results.class.should eq Hashie::Mash
    end

    it "returns a hash with the event in" do
      Allotment.record('my_recording 4.2') { sleep 0.01 }
      Allotment.results.should include('my_recording 4.2')
    end

    it "stores the result under the event" do
      Allotment.record('my_recording 4.3') { sleep 0.01 }
      Allotment.results['my_recording 4.3'][0].round(2).should eq 0.01
    end

    it "stores each result of each event" do
      Allotment.record('my_recording 4.4') { sleep 0.01 }
      Allotment.record('my_recording 4.4') { sleep 0.02 }
      Allotment.results['my_recording 4.4'][0].round(2).should eq 0.01
      Allotment.results['my_recording 4.4'][1].round(2).should eq 0.02
    end
  end
end