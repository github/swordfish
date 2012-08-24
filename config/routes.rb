Swordfish::Application.routes.draw do
  resources :items

  match '/signin' => 'sessions#new', :as => :sign_in
  match '/signout' => 'sessions#destroy', :as => :sign_out

  resource :key

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
