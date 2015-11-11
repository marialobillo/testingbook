class Location
  attr_accessor :latitude, :longitude
  R = 3_959 # Earth's radius in miles, approx
  def initialize(args = {})
    self.latitude = args[:latitude]
    self.longitude = args[:longitude]
  end

  def near?(latitude, longitude, mile_radius)
    to_radians = Proc.new { |d| d * Math::PI / 180 }
    dist_lat = to_radians.call(latitude - self.latitude)
    dist_long = to_radians.call(longitude - self.longitude )
    lat1 = to_radians.call(self.latitude)
    lat2 = to_radians.call(latitude)
    a = Math.sin(dist_lat/2) * Math.sin(dist_lat/2) +
        Math.sin(dist_long/2) * Math.sin(dist_long/2) *
        Math.cos(lat1) * Math.cos(lat2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    (R * c) <= mile_radius
  end
end
