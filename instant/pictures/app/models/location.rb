class Location < ActiveRecord::Base

  attr_accessor :latitude, :longitude
  R = 3_959 # Earth' radius in mi, approx
  def near?(latitude, longitude, mile_radius)
    #omitted
  end

  private
  def to_radians(degrees)
    #omitted
  end

  def haversine_distante(loc)
    #omitted
  end
end
