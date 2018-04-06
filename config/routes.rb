Rails.application.routes.draw do


  get 'users/index'

  get 'user/index'

  get "/" => "home#top"
  get "login" => "users#login_form"
  post "login" => "users#login"

  get "posts/index" =>"posts#index"





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
