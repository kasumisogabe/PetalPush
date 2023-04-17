FactoryBot.define do
  factory :flower do
    name { '桜' }
    description { '可愛い' }
    address { '東京タワー' }
    latitude { 35.65856 }
    longitude { 139.745461 }

    after(:build) do |flower|
      flower.image.attach(io: File.open("#{Rails.root}/spec/fixtures/test_image.jpg"), filename: 'test_image.jpg', content_type: 'image/jpeg')
    end
  end

  factory :second_flower, class: Flower do
    name { 'ひまわり' }
    description { '背が高いです' }
    address {'横浜駅'}
    latitude { 35.4660694 }
    longitude { 139.6226196 }

    after(:build) do |flower|
      flower.image.attach(io: File.open("#{Rails.root}/spec/fixtures/test_image2.jpg"), filename: 'test_image.jpg', content_type: 'image/jpeg')
    end
  end
end