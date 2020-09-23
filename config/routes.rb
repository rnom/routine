Rails.application.routes.draw do
  resources :workouts do
    collection do
      get 'next'
      get 'previous'
    end
  end

  devise_for :users
  
  resources :meals do
    collection do
      get 'next'
      get 'previous'
      get 'calendar'
    end
  end

  root 'meals#index'
  # root 'meals#calendar'
  resources :users, only: [:new, :create, :edit, :update, :show]
end
