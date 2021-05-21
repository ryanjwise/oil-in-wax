# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying old records'
User.destroy_all

puts 'Seeding started'
puts 'Creating tests user'

test_store_user = User.create(username: 'test_store', email:'test_store@address.com', password: 'password')
test_storeless_user = User.create(username: 'test_storeless', email:'test_storeless@address.com', password: 'password')

puts 'test users created'
puts 'creating test store'

test_store = test_store_user.create_store(name: 'test store')

puts 'test store created'
puts 'populating test store'

5.times do
  test_store.candles.create(
    price: rand(200..3000).to_f / 100,
    stock: rand(1..10),
    name: Faker::Food.fruits,
    description: Faker::Food.description,
    ingredients: Faker::Lorem.words(number: rand(2..12)),
    scents: Faker::Lorem.words(number: 3)
  )
end

puts 'test store populated'
puts 'creating order'



