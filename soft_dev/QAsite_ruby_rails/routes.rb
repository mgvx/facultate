Rails.application.routes.draw do


  # the page root
  root 'questions#index'

  resources :questions do
  	resources :answers
  end

  # routes for Devise and Omniauth
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  # routes for Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # routes for the API's
  namespace :api, defaults: {format: :json} do
    mount TolSkitSessions::Engine => "/"
    mount TolSkitSessionsFacebook::Engine => "sessions/facebook"
    mount TolSkitSessionsTwitter::Engine => "sessions/twitter"
    mount TolSkitSessionsInstagram::Engine => "sessions/instagram"

    resources :users
    resources :questions do
    	resources :answers
    end
  end

  # routes for locale change
  get 'sessions/:locale', to: "sessions#switch", as: :sessions

  # routes for Users
  resources :users

  # route for User Sign Out
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :signout
  end

  # routes for Omniauth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

end
