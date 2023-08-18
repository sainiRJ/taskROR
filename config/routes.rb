Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get '/user/register', to: 'users#create'

  post '/user/register', to: 'users#create'


  get '/user/list/:page', to: 'users#allUser'
 
 
  post 'user/login', to: 'users#login'
 
 
  get 'user/get/:id', to: 'users#get_user'
 
 
  delete '/user/delete/:id', to: 'users#delete_user'
end
