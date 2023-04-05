class User < ApplicationRecord
  has_many :flowers
  has_many :favorites, dependent: :destroy
  has_many :favorite_flowers, through: :favorites, source: :flower, dependent: :destroy
  #userがお気に入りした花の情報を取得できる

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable
end
