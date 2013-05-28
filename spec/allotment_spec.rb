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
    result = Allotment.record_event('name') { sleep 0.01 }
    result.round(2).should eq 0.01
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
    sleep 0.01
    result = Allotment.stop_recording 'my_recording2'
    result.round(2).should eq 0.01
  end

  it "raises an error if the recording does not exist" do
    expect { Allotment.stop_recording 'my_recording3' }.to raise_error NameError, "No recording:my_recording3"
  end
end

describe Allotment, "#results" do
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

describe Allotment::Stopwatch do
  it "is a class" do
    Allotment::Stopwatch.class.should eq Class
  end
end

describe Allotment::Stopwatch, "#new" do
  it "returns a class of Stopwatch" do
    Allotment::Stopwatch.new.class.should eq Allotment::Stopwatch
  end

  it "sets the stopwatch status to running" do
    Allotment::Stopwatch.new.status.should eq 'running'
  end

  it "sets the name of the stopwatch" do
    Allotment::Stopwatch.new('stopwatch').name.should eq 'stopwatch'
  end
end

describe Allotment::Stopwatch, "#stop" do
  it "returns a float" do
    sw = Allotment::Stopwatch.new
    sw.stop.class.should eq Float
  end

  it "returns the correct time" do
    sw = Allotment::Stopwatch.new
    sleep 0.01
    sw.stop.round(2).should eq 0.01
  end

  it "sets the stopwatch status to stopped" do
    sw = Allotment::Stopwatch.new
    sw.stop
    sw.status.should eq 'stopped'
  end

  it "keeps its stopwatch name" do
    sw = Allotment::Stopwatch.new('stopwatch')
    sw.stop
    sw.name.should eq 'stopwatch'
  end
end

describe Allotment::Stopwatch, "#start" do
  it "sets the stopwatch status to running" do
    sw = Allotment::Stopwatch.new
    sw.stop
    sw.start
    sw.status.should eq 'running'
  end

  it "keeps track of total time" do
    sw = Allotment::Stopwatch.new
    sleep 0.01
    sw.stop
    sw.start
    sleep 0.01
    sw.stop.round(2).should eq 0.02
  end

  it "keeps its stopwatch name" do
    sw = Allotment::Stopwatch.new('stopwatch')
    sw.stop
    sw.start
    sw.name.should eq 'stopwatch'
  end
end

describe Allotment::Stopwatch, "#reset" do
  it "resets the stopwatch total time when stopped" do
    sw = Allotment::Stopwatch.new
    sleep 0.01
    sw.stop
    sw.status.should eq 'stopped'
    sw.reset
    sw.start
    sleep 0.01
    sw.stop.round(2).should eq 0.01
  end

  it "resets the stopwatch total time when running" do
    sw = Allotment::Stopwatch.new
    sleep 0.01
    sw.status.should eq 'running'
    sw.reset
    sleep 0.01
    sw.stop.round(2).should eq 0.01
  end

  it "keeps its stopwatch name" do
    sw = Allotment::Stopwatch.new('stopwatch')
    sw.reset
    sw.name.should eq 'stopwatch'
  end
end

describe Allotment::Stopwatch, "#lap" do
  it "returns a float" do
    sw = Allotment::Stopwatch.new
    sw.lap.class.should eq Float
  end

  it "returns the correct time" do
    sw = Allotment::Stopwatch.new
    sleep 0.01
    sw.lap.round(2).should eq 0.01
    sleep 0.01
    sw.lap.round(2).should eq 0.02
  end

  it "keeps its stopwatch name" do
    sw = Allotment::Stopwatch.new('stopwatch')
    sw.lap
    sw.name.should eq 'stopwatch'
  end
end