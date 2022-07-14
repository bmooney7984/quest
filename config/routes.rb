Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :players, except: [:show, :edit, :update]
  resources :games
  resources :quests
  get "players/edit", to: "players#multi_edit", as: "edit_players"
  match "players", to: "players#multi_update", via: [:patch, :put]
  get "player/edit", to: "players#edit", as: "edit_current_player"
  match "player", to: "players#update", via: [:patch, :put], as: "current_player"
  # Defines the root path route ("/")
  # root "articles#index"
end
