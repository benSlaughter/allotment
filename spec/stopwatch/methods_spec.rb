class DummyClass
  include Allotment::Methods
end

describe Allotment::Methods do
  it "is a module" do
    Allotment::Methods.class.should eq Module
  end

  before(:each) do
    @dummy_class = DummyClass.new
  end

  describe "#record_event" do
    it "records the time for the block" do
      @dummy_class.record_event('my_recording 0.1') { sleep 0.01 }
    end

    it "records the time for the proc" do
      @dummy_class.record_event 'my_recording 0.2' do
        sleep 0.01
      end
    end

    it "returns a float" do
      result = @dummy_class.record_event('my_recording 0.3') { sleep 0.01 }
      result.class.should eq Float
    end

    it "returns the execute time of the block" do
      result = @dummy_class.record_event('my_recording 0.4') { sleep 0.01 }
      result.round(2).should eq 0.01
    end
  end

  describe "#start_recording" do
    it "returns a stopwatch instance" do
      result = @dummy_class.start_recording
      result.class.should eq Allotment::Stopwatch
    end

    it "returns an unnamed stopwatch if no name given" do
      result = @dummy_class.start_recording
      result.name.should eq 'unnamed'
    end

    it "returns a stopwatch with the given name" do
      result = @dummy_class.start_recording 'my_recording'
      result.name.should eq 'my_recording'
    end

    it "returns a stopwatch that is 'running'" do
      result = @dummy_class.start_recording
      result.status.should eq 'running'
    end
  end

  describe "#stop_recording" do
    it "returns a float" do
      @dummy_class.start_recording 'my_recording1'
      sleep 0.01
      result = @dummy_class.stop_recording 'my_recording1'
      result.class.should eq Float
    end

    it "returns the execute time of the code" do
      @dummy_class.start_recording 'my_recording2'
      sleep 0.01
      result = @dummy_class.stop_recording 'my_recording2'
      result.round(2).should eq 0.01
    end

    it "raises an error if the recording does not exist" do
      expect { @dummy_class.stop_recording 'my_recording3' }.to raise_error NameError, "No recording:my_recording3"
    end
  end

  describe "#results" do
    it "returns a hash" do
      @dummy_class.record_event('my_recording4') { sleep 0.01 }
      @dummy_class.results.class.should eq Hash
    end

    it "returns a hash with the event in" do
      @dummy_class.record_event('my_recording5') { sleep 0.01 }
      @dummy_class.results.should include('my_recording5')
    end

    it "stores the result under the event" do
      @dummy_class.record_event('my_recording6') { sleep 0.01 }
      @dummy_class.results['my_recording6'][0].round(2).should eq 0.01
    end

    it "stores each result of each event" do
      @dummy_class.record_event('my_recording7') { sleep 0.01 }
      @dummy_class.record_event('my_recording7') { sleep 0.02 }
      @dummy_class.results['my_recording7'][0].round(2).should eq 0.01
      @dummy_class.results['my_recording7'][1].round(2).should eq 0.02
    end
  end

  describe "#results_string" do
    it "returns a string" do
      @dummy_class.record_event('my_recording8') { sleep 0.01 }
      @dummy_class.results_string.class.should eq String
    end

    it "returns a string with the event in" do
      @dummy_class.record_event('my_recording9') { sleep 0.03 }
      @dummy_class.results_string.should include('my_recording9')
      @dummy_class.results_string.should include('0.03')
    end
  end
end