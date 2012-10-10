Swordfish::Application.routes.draw do
  resources :items

  resources :teams do
    resources :memberships
  end

  namespace :auth do
    resource :rsa, :only => [:create, :update], :controller => 'rsa'
  end

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
