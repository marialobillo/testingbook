require 'rails_helper'
require 'spec_helper'

RSpec.describe Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe Location do
  let(:latitude) { 40.39258072 }
  let(:longitude) { -3.69140625 }
  let(:air_space) { Location.new(:latitude => 40.39258072,
                                 :longitude => -3.69140625) }
  describe "#initialize" do
    it "sets the latitude and longitud" do
      loc = Location.new(:latitude => 40.39258072,
                         :longitude => -3.69140625)
     # loc.latitude.expect == 40.39258072
      expect(loc.latitude).to eq(40.39258072)
      expect(loc.longitude).to eq( -3.69140625)
    end
    it "sets the latitude to 0 and longitude to 1" do
      loc = Location.new(:latitude => 0, :longitude => 1)
      expect(loc.latitude).to eq(0)
      expect(loc.longitude).to eq(1)
    end
  end

  describe "#near?" do
    context "When whithin the specified radius" do
      subject { air_space }
      it { expect be_near(latitude, longitude, 1) }
    end
    context "When outside the specified radius" do
      subject { air_space }
      it { expect be_near(latitude * 10, longitude * 10, 1) }
    end
    context "when a negative radius is used" do
      it "raised an error" do
        expect { air_space.near?(latitude, longitude, -1) }
          .to raise_error ArgumentError
      end
    end
  end

  describe "validations" do
    before { subject.valid? }
    [ :latitude ].each do |coordinate|
      context "when #{coordinate} is nil" do
        subject { Location.new(coordinate => nil) }
        it "shouldn't allow blank #{coordinate}" do
          expect(subject.errors_on(coordinate))
            .to include("can't be blank")
        end
      end
  end
end
  end
end
