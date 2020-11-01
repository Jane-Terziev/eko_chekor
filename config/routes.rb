Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :sessions => 'users/sessions', :registrations => 'users/registrations'}
  root controller: :roots, action: :index
  resources :garbages
  post 'garbages/:id/cleaned', to: 'garbages#update_cleaned'
  get 'garbages/:id/reviewed', to: 'garbages#update_reviewed'
  get 'map', to: 'garbages#map'
  namespace :users do
    resources :results, only: [:index]
  end
end
