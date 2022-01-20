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

  get "chef_forget_password", to: "chef_password_resets#index"
  post "chef_forget_password", to: "chef_password_resets#create"
  get "chef_password_reset_edit", to: "chef_password_resets#edit"
  patch "chef_password_update", to: "chef_password_resets#update"

  get "waiter_forget_password", to: "waiter_password_reset#index"
  post "waiter_forget_password", to: "waiter_password_reset#create"
  get "waiter_password_reset_edit", to: "waiter_password_reset#edit"
  patch "waiter_password_update", to: "waiter_password_reset#update"
end
