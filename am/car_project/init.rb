require_relative('lib/car')

puts
puts "Enter information for the car you want to purchase."
puts

print "Make: "
make = gets.chomp

print "Year: "
year = gets.chomp

print "Color: "
color = get.chomp

car = Car.new(:make => make, :year => year, :color => color)

puts
puts "I undestand that you want to purchase: #{car.full_name}."
puts
