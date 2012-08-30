Swordfish::Application.routes.draw do
  resources :items

  namespace :auth do
    resource :rsa, :only => [:create, :update], :controller => 'rsa'
  end

  match 'mockup', :to => 'dashboard#mockup'

  resource :test if Rails.env.test?

  root :to => 'dashboard#index'
end
