FactoryBot.define do
  factory :flower do
    name { '桜' }
    description { '可愛い' }
    address { '東京タワー' }
    latitude { 35.65856 }
    longitude { 139.745461 }
  end

  factory :second_flower, class: Flower do
    name { 'テスト2' }
    description { 'テストの内容2' }
    address {'横浜駅'}
    latitude { 35.4660694 }
    longitude { 139.6226196 }
  end
end