Swordfish::Application.routes.draw do
  resources :items

  namespace :auth do
    resource :rsa, :only => [:create, :update], :controller => 'rsa'
  end

  match '/signout' => 'sessions#destroy', :as => :sign_out

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
