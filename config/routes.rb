Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'flowers#index'

  devise_for :users
  resources :flowers
  resources :favorites, only: [:index, :create, :destroy]
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
