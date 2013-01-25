Swordfish::Application.routes.draw do
  resources :items do
    resources :shares
  end

  resources :teams do
    resources :memberships
    resources :invites, :only => :create
  end

  get 'invites/:token' => 'invites#accept', :as => :accept_invite
  post 'invites/:token/fulfill' => 'invites#fulfill'

  namespace :auth do
    resource :rsa, :only => [:create, :update], :controller => 'rsa'
  end

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
