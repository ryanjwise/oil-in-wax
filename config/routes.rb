Rails.application.routes.draw do
  get 'purchases/new',         to: 'purchases#new',         as: 'new_purchase'
  get 'purchases/success',     to: 'purchases#success',     as: 'success'
  post 'purchases/webhook',    to: 'purchases#webhook'

  post 'cart/add',             to: 'cart#add_to_cart',      as: 'cart_add'
  delete 'cart/remove',        to: 'cart#remove_from_cart', as: 'cart_remove'
  delete 'cart/destroy/:id',   to: 'cart#destroy',          as: 'cart_destroy'

  get 'candle/new',            to: 'candle#new'
  post 'candle/create',        to: 'candle#create',         as: 'candle_create'
  get 'candle/show/:id',       to: 'candle#show',           as: 'candle_show'
  get 'candle/edit/:id',       to: 'candle#edit',           as: 'candle_edit'
  patch 'candle/update/:id',   to: 'candle#update',         as: 'candle_update'
  delete 'candle/destroy/:id', to: 'candle#destroy',        as: 'candle_destroy'

  get 'store/new',             to: 'store#new',             as: 'store_create'
  post '/stores',              to: 'store#create'
  get 'store/edit',            to: 'store#edit',            as: 'store_edit'
  patch '/store',              to: 'store#update'
  delete '/store',             to: 'store#destroy'
  get 'store/show/:id',        to: 'store#show',            as: 'store_show'
  get 'store/admin',           to: 'store#admin',           as: 'store_admin'

  # All references to home_path should have be removed however, route left just in case.
  get 'home/index',            to: 'home#index',            as: 'home'
  get 'home/profile',          to: 'home#profile',          as: 'profile'
  get 'home/edit/address',     to: 'home#edit_address',     as: 'edit_address'
  patch 'home/edit/address',   to: 'home#update_address',    as: 'address'

  root to: 'home#index'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
