Rails.application.routes.draw do
  get 'candle/new',      to: 'candle#new'
  post 'candle/create',  to: 'candle#create', as: 'candle_create'
  get 'candle/show/:id',     to: 'candle#show', as: 'candle_show'
  get 'candle/edit/:id', to: 'candle#edit', as: 'candle_edit'
  patch 'candle/update/:id',   to: 'candle#update',   as: 'candle_update'
  delete 'candle/destroy/:id',  to: 'candle#destroy', as: 'candle_destroy' 
  
  get 'store/new',       to: 'store#new',  as: 'store_create'
  post '/stores',        to: 'store#create'
  get 'store/edit',      to: 'store#edit', as: 'store_edit'
  patch '/store',        to: 'store#update'
  delete '/store',       to: 'store#destroy'
  get 'store/show',      to: 'store#show', as: 'store_show'
  get 'store/admin',     to: 'store#admin', as: 'store_admin'
  get 'home/index',      to: 'home#index', as: 'home'
  get '/',               to: 'home#index', as: 'home'
  
  root to: 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
