class Meal < ApplicationRecord
  # scope :previous, -> (meal) { where("created_at < ?", Date.today).order('id DESC').first }
  # scope :next, -> (meal) { where("created_at > ?", Date.today).order('id ASC').first }
end
