Rails.application.routes.draw do
  resources :workouts
  devise_for :users
  resources :meals
  root 'meals#index'
  resources :users, only: [:new, :create, :edit, :update]
end
