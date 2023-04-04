class Flower < ApplicationRecord
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[name description]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[flower]
  end
end
