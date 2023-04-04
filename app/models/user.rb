class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :flowers, dependent: :destroy

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable
end
