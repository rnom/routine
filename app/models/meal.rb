class Meal < ApplicationRecord
  # has_many   :favorites, dependent: :destroy
  validates :name, presence: true
  validates :protein, presence: true
  validates :fat, presence: true
  validates :carb, presence: true
  validates :cal, presence: true

  belongs_to :user
end
