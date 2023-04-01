Rails.application.routes.draw do
  resources :modal
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "modal#index"
end
