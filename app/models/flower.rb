class Flower < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user, dependent: :destroy
  #flowerをお気に入りした人の情報を取得する

  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[name description]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[flower]
  end
end
