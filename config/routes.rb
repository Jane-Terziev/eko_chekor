Rails.application.routes.draw do
  root controller: :healthcheck, action: :index
end
