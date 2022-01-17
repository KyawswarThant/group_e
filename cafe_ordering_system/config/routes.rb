Rails.application.routes.draw do
  get 'chefs/index'
  get 'chefs/new'
  root "waiter_login#index"
  
  resources :chefs 
  resources :waiters

  get 'chef_login', to: 'chef_login#index'
  post "chef_sign_in", to: "chef_login#sign_in"
  post "chef_sign_out", to: "chef_login#sign_out"
  get 'waiter_login', to: 'waiter_login#index'
  post "waiter_sign_in", to: "waiter_login#sign_in"
  post "waiter_sign_out", to: "waiter_login#sign_out"

end
