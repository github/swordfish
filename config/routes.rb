Swordfish::Application.routes.draw do
  resources :vaults do
    resources :items
  end

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
