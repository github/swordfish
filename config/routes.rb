Swordfish::Application.routes.draw do
  resources :vaults do
    resources :items
  end
  resources :objects


  match '/signin' => 'sessions#new', :as => :sign_in
  match '/signout' => 'sessions#destroy', :as => :sign_out
  match '/auth/failure' => 'sessions#failure'
  match '/auth/:provider/callback' => 'sessions#create'

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
