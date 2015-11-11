class Location
  attr_accessor :latitude, :longitude

  def initialize(args = {})
    self.latitude = args[:latitude]
    self.longitude = args[:longitude]
  end

  def near?(latitude, longitude, mile_radius)
    true
  end
end
