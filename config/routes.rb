Rails.application.routes.draw do
  # resources :answers
  resources :votes, only: [:create, :destroy]
  resources :comments, only: [:create]
  resources :answers, only: [:create]
  resources :questions
  devise_for :users
  root 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
