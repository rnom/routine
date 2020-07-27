Rails.application.routes.draw do
  resources :workouts
  devise_for :users
  
  resources :meals do
    collection do
      get 'next'
      get 'previous'
    end
  end

  root 'meals#index'
  resources :users, only: [:new, :create, :edit, :update]
end
