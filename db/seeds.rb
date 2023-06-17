# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

Desk.destroy_all
#User.destroy_all

# 5.times do
#   User.create(
#     first_name: Faker::Internet.username,
#     last_name: Faker::BossaNova.artist,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password,
#     address: Faker::Address.city,
#     phone_number: Faker::Barcode.ean
#   )
# end

20.times do
  desk = Desk.new(
    # title: Faker::Creature::Dog.meme_phrase,
    title: "#{Faker::Adjective.positive.capitalize} Desk in #{Faker::Address.city}",
    name: Faker::Name.first_name,
    price: (10..25).to_a.sample,
    age: (21..66).to_a.sample,
    address: Faker::Address.city,
    description: Faker::Lorem.sentence,
  )
  desk.user = User.all.sample
  desk.latitude = Faker::Address.latitude
  desk.longitude = Faker::Address.longitude
  file = URI.open("https://source.unsplash.com/random/320x240/?desk")
  desk.photos.attach(io: file, filename: "#{desk.name}.jpeg", content_type: "image/jpeg")
  desk.save!
end

puts "seed finished, users and desks created"
