require "spec_helper"



describe Location do
  describe "#initialize" do
    it "sets the latitude and longitud" do
      loc = Location.new(:latitude => 40.39258072,
                         :longitude => -3.69140625)
      loc.latitude.should == 40.39258072
      loc.longitude.should ==  -3.69140625
    end
    it "sets the latitude to 0 and longitude to 1" do
      loc = Location.new(:latitude => 0, :longitude => 1)
      loc.latitude.should == 0
      loc.longitude.should == 1
    end
  end
end
