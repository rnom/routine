class Meal < ApplicationRecord
  def protein_total
    sum(:protein).round(1)
  end
end
