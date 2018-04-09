Rails.application.routes.draw do

  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "signup" => "users#new"
  post "users/create" => "users#create"

  get "/" => "home#top"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  get "login" => "users#login_form"
  post "login" => "users#login"

  get "posts/index" =>"posts#index"





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
