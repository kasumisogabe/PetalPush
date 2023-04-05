Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'flowers#index'

  devise_for :users
  resources :flowers
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:show, :edit, :update]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
