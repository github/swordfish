Passwords::Application.routes.draw do
  resources :vaults
  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
