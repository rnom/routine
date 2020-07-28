json.array! @meals, partial: "meals/meal", as: :meal
json.protein @meal_data.protein
json.fat @meal_data.fat
json.carb @meal_data.carb
json.cal @meal_data.cal

