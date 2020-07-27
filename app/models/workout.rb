class Workout < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :brand, optional: true
  validates :name, :description, :price, :condition, :parent_category_id, :child_category_id, :category, :shipping, :images, presence: true
end
