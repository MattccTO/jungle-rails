# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Data ..."

# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

# Only run on development (local) instances not on production, etc.
unless Rails.env.development?
  puts "Development seeds only (for now)!"
  exit 0
end

# Let's do this ...

## CATEGORIES

puts "Finding or Creating Categories ..."

cat1 = Category.find_or_create_by! name: 'Apparel'
cat2 = Category.find_or_create_by! name: 'Electronics'
cat3 = Category.find_or_create_by! name: 'Furniture'

## PRODUCTS

puts "Re-creating Products ..."

Product.destroy_all

cat1.products.create!({
  name:  'Men\'s Classy shirt',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel1.jpg'),
  quantity: 0,
  price: 64.99
})

cat1.products.create!({
  name:  'Women\'s Zebra pants',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel2.jpg'),
  quantity: 18,
  price: 124.99
})

cat1.products.create!({
  name:  'Hipster Hat',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel3.jpg'),
  quantity: 4,
  price: 34.49
})

cat1.products.create!({
  name:  'Hipster Socks',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel4.jpg'),
  quantity: 8,
  price: 25.00
})

cat1.products.create!({
  name:  'Russian Spy Shoes',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel5.jpg'),
  quantity: 8,
  price: 1_225.00
})

cat1.products.create!({
  name:  'Human Feet Shoes',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel6.jpg'),
  quantity: 82,
  price: 224.50
})


cat2.products.create!({
  name:  'Modern Skateboards',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics1.jpg'),
  quantity: 40,
  price: 164.49
})

cat2.products.create!({
  name:  'Hotdog Slicer',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics2.jpg'),
  quantity: 3,
  price: 26.00
})

cat2.products.create!({
  name:  'World\'s Largest Smartwatch',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics3.jpg'),
  quantity: 32,
  price: 2_026.29
})

cat3.products.create!({
  name:  'Optimal Sleeping Bed',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture1.jpg'),
  quantity: 320,
  price: 3_052.00
})

cat3.products.create!({
  name:  'Electric Chair',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture2.jpg'),
  quantity: 2,
  price: 987.65
})

cat3.products.create!({
  name:  'Red Bookshelf',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture3.jpg'),
  quantity: 23,
  price: 2_483.75
})

cat3.products.create!({
  name:  'Hipster Pillow',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('Hipster Pillow.jpg'),
  quantity: 42,
  price: 42.13
})

puts "Creating Users"

User.destroy_all

user1 = User.new
user1.first_name =  'Tara'
user1.last_name = 'Test'
user1.email = 'tara@test.com'
password1 = '1234'
user1.password = password1
user1.save

user2 = User.new
user2.first_name =  'Timmy'
user2.last_name = 'Test'
user2.email = 'timmy@test.com'
user2.password = password1
user2.save

user3 = User.new
user3.first_name =  'Del'
user3.last_name = 'Tron'
user3.email = 'del@tron.com'
user3.password = password1
user3.save

puts "Creating Reviews"

Review.destroy_all

review1 = Review.new
review1.product_id = 1
review1.user_id = 1
review1.description = "I bought all 42 of these shirts. I'm going to be the Steve Jobs of Liberty Village."
review1.rating = 5
review1.save

review2 = Review.new
review2.product_id = 12
review2.user_id = 2
review2.description = "I really love my new seussian bookshelf. It fits almost all of the books I have never read. I just wish it was a biiit more cumbersome."
review2.rating = 4
review2.save

review3 = Review.new
review3.product_id = 6
review3.user_id = 2
review3.description = "I bought these and my girlfriend left me..."
review3.rating = 1
review3.save

review4 = Review.new
review4.product_id = 6
review4.user_id = 1
review4.description = "I bought these and never take them off and now I just think of them as my real feet."
review4.rating = 3
review4.save

review5 = Review.new
review5.product_id = 6
review5.user_id = 3
review5.description = "They should be hairier."
review5.rating = 2
review5.save

puts "DONE!"
