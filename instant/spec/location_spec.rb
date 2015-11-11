require "spec_helper"

describe Location do
  let(:latitude) { 40.39258072 }
  let(:longitude) { -3.69140625 }
  let(:air_space) { Location.new(:latitude => 40.39258072,
                                 :longitude => -3.69140625) }
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

  describe "#near?" do
    context "When whithin the specified radius" do
      subject { air_space }
       it { should be_near(latitude, longitude, 1) }
    end
    context "When outside the specified radius" do
      subject { air_space }
      it { should_not be_near(latitude * 10, longitude * 10, 1) }
    end
    context "when a negative radius is used" do
      it "raised an error" do
        expect { air_space.near?(latitude, longitude, -1) }
          .to raise_error ArgumentError
      end
    end
  end

  
end
