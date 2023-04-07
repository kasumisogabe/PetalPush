class Comment < ApplicationRecord
  belongs_to :flower
  validates :content, presence: true
end
