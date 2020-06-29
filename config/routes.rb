Rails.application.routes.draw do
  root to: 'stays#index'
  resources :stays, only: [:index]
end
