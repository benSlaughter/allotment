describe Array do
  describe "#average" do
    it "returns a float" do
      [1,2,3,4,5].average.class.should eq Float
    end

    it "returns the mean of the array" do
      [1,2,3,4,5,6,7,7].average.should eq 4.375
    end

    it "raises an error if one of the values is not a fixnum" do
      expect { [1,2,3,4,5,'invalid'].average }.to raise_error TypeError, "String can't be coerced into Fixnum"
    end
  end
end