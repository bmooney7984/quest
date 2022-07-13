Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :players, except: [:edit, :update, :show]
  resources :games
  resources :quests
  get "players/edit", to: "players#edit", as: "edit_players"
  match "players", to: "players#update", via: [:patch, :put]
  # Defines the root path route ("/")
  # root "articles#index"
end
