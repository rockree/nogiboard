Rails.application.routes.draw do


  get 'posts/index' => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"

  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "signup" => "users#new"
  post "users/create" => "users#create"

  get "/" => "home#top"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"

  get "login" => "users#login_form"
  post "login" => "users#login"


  post "logout" => "users#logout"




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
