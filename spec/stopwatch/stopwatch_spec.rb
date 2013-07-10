describe Allotment::Stopwatch do
  it "is a class" do
    Allotment::Stopwatch.class.should eq Class
  end

  describe ".new" do
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

  describe ".stop" do
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

  describe ".start" do
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

  describe ".reset" do
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

  describe ".lap" do
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
end