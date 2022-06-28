Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :players, only: [:new, :create]
  resources :games, only: [:new, :create, :show, :edit, :update]
  # Defines the root path route ("/")
  # root "articles#index"
end
