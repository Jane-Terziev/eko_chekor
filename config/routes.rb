Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root controller: :healthcheck, action: :index
  delete 'users/sessions', to: 'users/sessions#destroy'
end
