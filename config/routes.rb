Rails.application.routes.draw do

  root to: 'dashboard#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'
  get 'error' => 'dashboard#error'
  get 'error_parcial' => 'dashboard#error_parcial'

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
