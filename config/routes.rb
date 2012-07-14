Passwords::Application.routes.draw do
  resources :vaults
  root :to => 'dashboard#index'
end
