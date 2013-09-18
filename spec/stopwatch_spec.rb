require 'helper'

describe Allotment::Stopwatch do
  it "is a class" do
    Allotment::Stopwatch.class.should eq Class
  end

  describe ".new" do
    it "returns a class of Stopwatch" do
      Allotment::Stopwatch.new.class.should eq Allotment::Stopwatch
    end

    it "sets the stopwatch status to stopped" do
      Allotment::Stopwatch.new.status.should eq 'stopped'
    end

    it "gives the stopwatch a name if none given" do
      Allotment::Stopwatch.new.name.should =~ /stopwatch_\d+/
    end

    it "sets the name of the stopwatch" do
      Allotment::Stopwatch.new('stopwatch').name.should eq 'stopwatch'
    end
  end

  describe "#inspect" do
    it "returns the correct inspect string when created" do
      sw = Allotment::Stopwatch.new
      sw.inspect.should eq "#<Stopwatch:stopped>"
    end

    it "returns the correct inspect string when running" do
      sw = Allotment::Stopwatch.new.start
      sw.inspect.should eq "#<Stopwatch:running>"
    end

    it "returns the correct inspect string when stopped" do
      sw = Allotment::Stopwatch.new.start
      sw.stop
      sw.inspect.should eq "#<Stopwatch:stopped>"
    end
  end

  describe "#start" do
    it "sets the stopwatch status to running" do
      sw = Allotment::Stopwatch.new.start
      sw.stop
      sw.start
      sw.status.should eq 'running'
    end

    it "keeps track of total time" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.stop
      sw.start
      sleep 0.01
      sw.stop.round(2).should eq 0.02
    end

    it "keeps its stopwatch name" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sw.stop
      sw.start
      sw.name.should eq 'stopwatch'
    end
  end

  describe "#stop" do
    it "returns a float" do
      sw = Allotment::Stopwatch.new.start
      sw.stop.class.should eq Float
    end

    it "returns the correct time" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.stop.round(2).should eq 0.01
    end

    it "sets the stopwatch status to stopped" do
      sw = Allotment::Stopwatch.new.start
      sw.stop
      sw.status.should eq 'stopped'
    end

    it "keeps its stopwatch name" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sw.stop
      sw.name.should eq 'stopwatch'
    end
  end

  describe "#reset" do
    it "resets the stopwatch total time when stopped" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.stop
      sw.reset
      sw.start
      sleep 0.01
      sw.stop.round(2).should eq 0.01
    end

    it "resets the stopwatch total time when running" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.reset
      sleep 0.01
      sw.stop.round(2).should eq 0.01
    end

    it "keeps its stopwatch name" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sw.reset
      sw.name.should eq 'stopwatch'
    end
  end

  describe "#split" do
    it "returns a float" do
      sw = Allotment::Stopwatch.new.start
      sw.split.class.should eq Float
    end

    it "returns the correct time" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.split.round(2).should eq 0.01
      sleep 0.01
      sw.split.round(2).should eq 0.02
    end

    it "returns the correct time while stopped" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.split.round(2).should eq 0.01
      sw.stop
      sleep 0.01
      sw.split.round(2).should eq 0.01
    end

    it "returns the time from the last start" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.split.round(2).should eq 0.01
      sw.stop
      sleep 0.01
      sw.start
      sleep 0.01
      sw.split.round(2).should eq 0.01
    end

    it "keeps its stopwatch name" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sw.split
      sw.name.should eq 'stopwatch'
    end
  end

  describe "#lap" do
    it "returns a float" do
      sw = Allotment::Stopwatch.new.start
      sw.lap.class.should eq Float
    end

    it "returns the correct time" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.lap.round(2).should eq 0.01
      sleep 0.01
      sw.lap.round(2).should eq 0.01
    end

    it "returns the correct time over stop/start" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.lap.round(2).should eq 0.01
      sw.stop
      sleep 0.01
      sw.start
      sleep 0.01
      sw.lap.round(2).should eq 0.01
    end

    it "keeps its stopwatch name" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sw.lap
      sw.name.should eq 'stopwatch'
    end
  end

  describe "#time" do
    it "displays the current time while running" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sleep 0.01
      sw.time.round(2).should eq 0.01
      sleep 0.01
      sw.time.round(2).should eq 0.02
    end

    it "displays the current time while stopped" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sleep 0.01
      sw.time.round(2).should eq 0.01
      sw.stop
      sleep 0.01
      sw.time.round(2).should eq 0.01
    end

    it "returns the correct time over stop/start" do
      sw = Allotment::Stopwatch.new.start
      sleep 0.01
      sw.stop
      sleep 0.01
      sw.start
      sleep 0.01
      sw.time.round(2).should eq 0.02
    end

    it "displays the current time when the stopwatch has been restarted" do
      sw = Allotment::Stopwatch.new('stopwatch').start
      sleep 0.01
      sw.stop
      sw.time.round(2).should eq 0.01
      sleep 0.01
      sw.start
      sleep 0.01
      sw.time.round(2).should eq 0.02
    end
  end
end