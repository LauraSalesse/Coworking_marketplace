# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"

puts "cleaning database!"
Booking.destroy_all
Desk.destroy_all
Review.destroy_all
User.destroy_all
puts "database is clean!"


puts "creating user...."
# seeding user
user = User.create!(
  email: "martin@example.com",
  password: "password",
  name: "Martin Dupont",
  description: "I am design freelancer working remote and I love trying out different workspace, especially when there is coffee!"
)
puts "user created!"

puts "creating desks..."
# seeding desks
desk1 = Desk.create!(
  title: "Sunny Desk in Tokyo",
  description: "Quiet desk in a stylish coworking.",
  address: "1-chōme-6 Ōmorikita, Ota City, Tokyo 143-0016, Japan",
  location: "Ota City, Tokyo",
  shared: true,
  price: 45,
  user: user
)
desk1.photos.attach([
  {
    io: URI.open("https://res.cloudinary.com/dfqc2bsdp/image/upload/v1749126843/development/iv6uc2b2izhejb5iafm9s7rn65wj.webp"),
    filename: "desk1Tokyo.jpg",
    content_type: "image/jpeg"
  }
])

desk2 = Desk.create!(
  title: "Elegant Workspace in Paris Apartment",
  description: "Charming desk space in a Haussmann-style apartment near Le Marais. Ideal for writers and designers.",
  address: "12 Rue des Archives, 75003 Paris, France",
  location: "Paris, Le Marais",
  shared: false,
  price: 50,
  user: user
)
desk2.photos.attach([
    {
    io: URI.open("https://res.cloudinary.com/dfqc2bsdp/image/upload/v1749126627/development/6fvoi4q48er64ne4kn8r8qkjc7rt.webp"),
    filename: "desk1Paris.jpg",
    content_type: "image/jpeg"
  }
])

desk3 = Desk.create!(
  title: "Rustic Barn Loft Desk",
  description: "Come and work in my barn. Quiet, rural, and full of character — strong WiFi included.",
  address: "Chambige, 19200 Chaveroche",
  location: "Chaveroche, Auvergne",
  shared: true,
  price: 30,
  user: user

)
desk3.photos.attach([
   {
    io: URI.open("https://res.cloudinary.com/dfqc2bsdp/image/upload/v1749126629/development/1pqg44aa9zrhm3fu1tfdoak4m2tc.webp"),
    filename: "desk1barn.jpg",
    content_type: "image/jpeg"
  },
     {
    io: URI.open("https://res.cloudinary.com/dfqc2bsdp/image/upload/v1749126631/development/73wdpdffngakl8bqfhj8joqo8d6m.jpg"),
    filename: "desk2barn.jpg",
    content_type: "image/jpeg"
  }
])
puts "desks created!"

puts "seeding bookings..."
  Booking.create!(
    user: user,
    desk: desk1,
    start_date: Date.today + 1,
    end_date: Date.today + 3
  )

  Booking.create!(
    user: user,
    desk: desk1,
    start_date: Date.today + 5,
    end_date: Date.today + 8
  )

  Booking.create!(
  user: user,
  desk: desk2,
  start_date: Date.today + 20,
  end_date: Date.today + 20
)

puts "bookings created! To see them, log in under test@example.com, and password = password"
