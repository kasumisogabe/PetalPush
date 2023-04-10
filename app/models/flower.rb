class Flower < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  #flowerをお気に入りした人の情報を取得する
  has_many :favorite_users, through: :favorites, source: :user, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.ransackable_attributes(auth_object = nil)
    %w[name description address]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[flower]
  end
end
