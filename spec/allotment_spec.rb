require 'coveralls'
Coveralls.wear!

require 'allotment'

describe Allotment do
  it "is a module" do
    Allotment.class.should eq Module
  end
end

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
    result = Allotment.start_recording 'my_recording'
    result.name.should eq 'my_recording'
  end

  it "returns a stopwatch that is 'running'" do
    result = Allotment.start_recording
    result.status.should eq 'running'
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

describe Allotment::Stopwatch, "#new" do
  it "returns a class of Stopwatch" do
    Allotment::Stopwatch.new.class.should eq Allotment::Stopwatch
  end

  it "sets the name of the stopwatch" do
    Allotment::Stopwatch.new('stopwatch').name.should eq 'stopwatch'
  end

  it "sets the stopwatch status to running" do
    Allotment::Stopwatch.new('stopwatch').status.should eq 'running'
  end
end