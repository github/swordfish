Swordfish::Application.routes.draw do
  resources :items

  match '/signin' => 'sessions#new', :as => :sign_in
  match '/signout' => 'sessions#destroy', :as => :sign_out
  match '/auth/failure' => 'sessions#failure'
  match '/auth/:provider/callback' => 'sessions#create'

  resource :key

  match 'mockup', :to => 'dashboard#mockup'

  resource :test if Rails.env.test?

  root :to => 'dashboard#index'
end
