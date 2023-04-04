Rails.application.routes.draw do
  root 'flowers#index'

  devise_for :users
  resources :flowers
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
