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
  email: "test@example.com",
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
  location: "Tokyo",
  shared: true,
  price: 45,
  user: user
)
desk1.photos.attach([
  {
    io: URI.open("https://cdn.midjourney.com/1c9d0758-92dd-415e-90ff-c540f86d2922/0_0.png"),
    filename: "desk1Tokyo.jpg",
    content_type: "image/jpeg"
  }
])

desk2 = Desk.create!(
  title: "Elegant Workspace in Paris Apartment",
  description: "Charming desk space in a Haussmann-style apartment near Le Marais. Ideal for writers and designers.",
  address: "12 Rue des Archives, 75003 Paris, France",
  location: "Le Marais",
  shared: false,
  price: 50,
  user: user
)
desk2.photos.attach([
    {
    io: URI.open("https://cdn.midjourney.com/fb17dcde-1190-4300-804c-bd3c40fbbc24/0_3.png"),
    filename: "desk1Paris.jpg",
    content_type: "image/jpeg"
  }
])

desk3 = Desk.create!(
  title: "Rustic Barn Loft Desk",
  description: "Come and work in my barn. Quiet, rural, and full of character — strong WiFi included.",
  address: "Chambige, 19200 Chaveroche",
  location: "Auvergne",
  shared: true,
  price: 30,
  user: user

)
desk3.photos.attach([
   {
    io: URI.open("https://cdn.midjourney.com/157bd89b-68f5-4e38-b316-b26e27ab9854/0_1.png"),
    filename: "desk1barn.jpg",
    content_type: "image/jpeg"
  },
     {
    io: URI.open("https://assets.hvmag.com/2023/05/LMGzByD0-BackyardBarn5.jpg"),
    filename: "desk2barn.jpg",
    content_type: "image/jpeg"
  }
])
puts "desks created!"
