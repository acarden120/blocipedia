# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

  # Create an admin user
 admin = User.new(
   name:     'Admin User',
   email:    'admin2@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!

  # Create an standard test user
 admin = User.new(
   name:     'Test User',
   email:    'test@example.com',
   password: 'abc123456',
   role:     'standard'
 )
 admin.skip_confirmation!
 admin.save!

 # Create an standard test user
 admin = User.new(
   name:     'Test2 User2',
   email:    'test2@example.com',
   password: 'abc654321',
   role:     'premium'
 )
 admin.skip_confirmation!
 admin.save!

10.times do 
	user = User.new(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: Faker::Lorem.characters(10)
	)
	user.skip_confirmation!
	user.save!
end
users = User.all

20.times do
  wiki = Wiki.create(
    user: users.sample,
    title:         Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
  wiki.update_attributes!(created_at: rand(10.minutes..1.years).ago)
end
wikis = Wiki.all

puts "Users created: #{User.count}"
puts "Wikis created: #{Wiki.count}"