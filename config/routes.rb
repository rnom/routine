Rails.application.routes.draw do
  resources :meals
  root 'meals#index'
end
