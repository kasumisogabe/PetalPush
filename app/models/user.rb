class User < ApplicationRecord
  has_many :flowers
  has_many :favorites, dependent: :destroy
  has_many :favorite_flowers, through: :favorites, source: :flower, dependent: :destroy
  has_one_attached :profile_image
  #userがお気に入りした花の情報を取得できる

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable
  
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: :password_required?, allow_blank: true
  validates :password_confirmation, presence: true, if: :password_required?

  private

  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end
end
