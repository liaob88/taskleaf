Rails.application.routes.draw do
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/login', to: 'session#destroy'
  get 'session/destroy'
  namespace :admin do
    resources :users
  end
  root to: "tasks#index"
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
