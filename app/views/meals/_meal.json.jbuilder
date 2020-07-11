json.extract! meal, :id, :name, :protein, :fat, :carb, :cal, :created_at, :updated_at
json.url meal_url(meal, format: :json)
