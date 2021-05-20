Rails.application.routes.draw do
  get 'store/new',  to: 'store#new',  as: 'store_create'
  post '/stores',   to: 'store#create'
  get 'store/edit',  to: 'store#edit', as: 'store_edit'
  patch '/store',  to: 'store#update'
  delete '/store', to: 'store#destroy'

  get 'store/show', to: 'store#show', as: 'store_show'
  get 'store/admin', to: 'store#admin', as: 'store_admin'
  get 'home/index', to: 'home#index', as: 'home'
  
  root to: 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
