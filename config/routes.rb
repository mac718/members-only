Rails.application.routes.draw do

  get 'users/create'

  get 'users/edit'

  get 'users/destroy'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  resources :users
  resources :posts, only: [:new, :create, :index]
end
