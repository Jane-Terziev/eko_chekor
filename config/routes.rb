Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :sessions => 'users/sessions', :registrations => 'users/registrations'}
  root controller: :roots, action: :index
  resources :garbages
  get 'map', to: 'garbages#map'
  namespace :users do
    resources :results, only: [:index]
  end
end
