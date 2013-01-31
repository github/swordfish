Swordfish::Application.routes.draw do
  resources :items do
    resources :shares
  end

  resources :teams do
    resources :memberships
    resources :invites, :only => :create do
      member do
        post :fulfill
      end
    end
  end

  get 'invites' => 'invites#index', :as => :invites
  get 'invites/:token' => 'invites#accept', :as => :accept_invite

  namespace :auth do
    resource :rsa, :only => [:create, :update], :controller => 'rsa'
  end

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
