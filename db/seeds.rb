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
  location: "Ota City, Tokyo",
  shared: true,
  price: 45,
  user: user
)
desk1.photos.attach([
  {
    io: URI.open("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgpUw4rN6Vzr5e7MYPJ--ffRZO-35RPzfg1g&s"),
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
    io: URI.open("https://media.discordapp.net/attachments/1270745752829825086/1379812063915933726/paris.png?ex=6841999f&is=6840481f&hm=a30df98728b61f75cd5dbd919380f471c8a5900bb8def655619205db1e817c13&=&format=webp&quality=lossless&width=930&height=620"),
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
    io: URI.open("https://media.discordapp.net/attachments/1270745752829825086/1379812063207227444/barn.png?ex=6841999f&is=6840481f&hm=70461294c2ff4b5b19c15dd317a4a20bd00e989d17760ba9d344554a7c3d206f&=&format=webp&quality=lossless&width=930&height=620"),
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
