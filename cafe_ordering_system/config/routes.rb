Rails.application.routes.draw do
  root "waiter_login#index"

  resources :chefs
  resources :waiters

  get "chef_login", to: "chef_login#index"
  post "chef_sign_in", to: "chef_login#sign_in"
  post "chef_sign_out", to: "chef_login#sign_out"
  get "waiter_login", to: "waiter_login#index"
  post "waiter_sign_in", to: "waiter_login#sign_in"
  post "waiter_sign_out", to: "waiter_login#sign_out"

  get "chef_profile", to: "chefs#chef_profile"
  get "edit_profile", to: "chefs#edit_profile"

  get "password", to: "chefs#change_password"
  post "password", to: "chefs#update_password"

  get "waiter_profile", to: "waiters#waiter_profile"
  get "waiter_edit_profile", to: "waiters#waiter_edit_profile"
  get "waiter_password", to: "waiters#waiter_change_password"
  post "waiter_password", to: "waiters#waiter_update_password"
end
