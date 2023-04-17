# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

5.times do
  user = User.create!(
    name: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )

  flower = Flower.create!(
    name: Faker::Lorem.words(number: 2).join(' '),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user_id: user.id
  )

  Comment.create!(
    content: Faker::Lorem.sentence,
    flower_id: flower.id
  )

  # ダウンロードするサンプル画像のURL
  image_url = 'https://picsum.photos/200/300'

  # ActiveStorageを使って画像をアタッチ
  image = URI.open(image_url)
  flower.image.attach(io: image, filename: "sample_image_#{flower.id}.jpg", content_type: 'image/jpg')
end