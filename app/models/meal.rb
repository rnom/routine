class Meal < ApplicationRecord
  # has_many   :favorites, dependent: :destroy
  belongs_to :user
end
