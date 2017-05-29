Rails.application.routes.draw do

  root to: 'dashboard#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :sessions

end
