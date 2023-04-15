Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'flowers#index'

  devise_for :users
  resources :flowers do
    resources :comments
  end
  resources :favorites, only: [:index, :create, :destroy]
  resources :users, only: [:show, :edit, :update] do
    get :favorites, on: :collection
  end
  get 'flowers/index'
  resources :maps
  resources :tops, only: [:index]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
