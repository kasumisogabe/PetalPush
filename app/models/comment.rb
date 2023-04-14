class Comment < ApplicationRecord
  belongs_to :flower

  validates :content, presence: true, length: { maximum: 300 }
end
