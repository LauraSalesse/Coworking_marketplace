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
    io: URI.open("https://sdmntpritalynorth.oaiusercontent.com/files/00000000-a818-6246-93e8-253143fd5310/raw?se=2025-06-03T11%3A44%3A12Z&sp=r&sv=2024-08-04&sr=b&scid=8baaa1fc-78f0-598d-a6cf-4de3d2017216&skoid=0a4a0f0c-99ac-4752-9d87-cfac036fa93f&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-06-03T09%3A21%3A59Z&ske=2025-06-04T09%3A21%3A59Z&sks=b&skv=2024-08-04&sig=pCC/s7CmFTLebU895JkftHACzBqh299YKA0pCsIXaos%3D"),
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
    io: URI.open("https://officesnapshots.com/wp-content/uploads/2019/11/pwc-experience-center-offices-paris-2.jpg"),
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
    io: URI.open("https://sdmntpreastus2.oaiusercontent.com/files/00000000-1ae8-61f6-848a-d2a5af27422c/raw?se=2025-06-03T11%3A37%3A37Z&sp=r&sv=2024-08-04&sr=b&scid=ace78cb0-cf6e-577f-8d1e-ca882fe7e1d9&skoid=0a4a0f0c-99ac-4752-9d87-cfac036fa93f&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-06-02T22%3A59%3A45Z&ske=2025-06-03T22%3A59%3A45Z&sks=b&skv=2024-08-04&sig=xmRZm6T54iddPbWL3p/i9o3ChEiNi7e8VhiWRsmi1FQ%3D"),
    filename: "desk1barn.jpg",
    content_type: "image/jpeg"
  },
     {
    io: URI.open("https://www.vivaweek.com/media/cache/thumb_840x530/img/locvac-photos/542090/location-vacances-gite--542090-1.jpg?310320124217"),
    filename: "desk2barn.jpg",
    content_type: "image/jpeg"
  }
])
puts "desks created!"
