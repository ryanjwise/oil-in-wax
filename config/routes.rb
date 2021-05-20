Rails.application.routes.draw do
  get 'store/new'
  get 'store/show'
  root to: 'home#index'
  
  get 'home/index', to: 'home#index', as: 'home'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
