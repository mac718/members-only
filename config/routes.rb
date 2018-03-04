Rails.application.routes.draw do
  #get 'posts/new'

  get 'posts/create'

  get 'posts/index'

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  resources :users
  resources :posts, only: [:new, :create, :index]
end
