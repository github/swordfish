Swordfish::Application.routes.draw do
  resources :items

  namespace :auth do
    resource :rsa, :only => [:create, :update], :controller => 'rsa'
  end

  match 'mockup', :to => 'dashboard#mockup'
  match "signout", :to => "session#signout"
  root :to => 'dashboard#index'
end
