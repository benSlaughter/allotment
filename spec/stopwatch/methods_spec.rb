class DummyClass
end

describe Allotment::Methods do
  it "is a module" do
    Allotment::Methods.class.should eq Module
  end

  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Allotment::Methods)
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
end