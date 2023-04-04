Rails.application.routes.draw do
  devise_for :users
  resources :flowers
  root 'flowers#index'
end
