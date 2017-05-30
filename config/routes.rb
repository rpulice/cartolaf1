Rails.application.routes.draw do

  root to: 'dashboard#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'
  get 'error' => 'dashboard#error'

  resources :users
  resources :teams do
    member do
      post :toggle_status
    end
  end
  resources :sessions
  resources :parcials
  resources :alyssons
  resources :points

end
