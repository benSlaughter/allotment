require 'coveralls'
Coveralls.wear!

require './lib/allotment'

describe Allotment, "#record_event" do
  it "records the time for the block" do
    Allotment.record_event('name') { nil }
  end

  it "returns a float" do
    result = Allotment.record_event('name') { nil }
    result.class.should eq Float
  end

  it "returns the execute time of the block" do
    result = Allotment.record_event('name') { sleep 0.1 }
    result.round(1).should eq 0.1
  end
end

describe Allotment, "#start_recording" do
  it "returns a stopwatch instance" do
    result = Allotment.start_recording
    result.class.should eq Allotment::Stopwatch
  end

  it "returns a stopwatch with the given name" do
    result = Allotment.start_recording
    result.class.should eq Allotment::Stopwatch
  end

  it "returns a stopwatch that is 'running'" do
    result = Allotment.start_recording 'my_recording'
    result.name.should eq 'my_recording'
  end
end

describe Allotment, "#stop_recording" do
  it "returns a float" do
    Allotment.start_recording 'my_recording1' 
    result = Allotment.stop_recording 'my_recording1'
    result.class.should eq Float
  end

  it "returns the execute time of the code" do
    Allotment.start_recording 'my_recording2'
    sleep 0.1
    result = Allotment.stop_recording 'my_recording2'
    result.round(1).should eq 0.1
  end
end