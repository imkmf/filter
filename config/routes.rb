Filter::Application.routes.draw do
  root "high_voltage/pages#show", id: "home"
  resources :podcasts, except: [:index]
  resources :subscriptions
  resources :users, only: [:edit, :update]
  resources :episodes
  get "/utilities/hello"
  get "/auth/:provider/:callback", to: "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/my_podcast", to: "podcasts#show"
  post "/users/remove_card", to: "subscriptions#remove_card", as: "remove_card"
  post "/subscriptions/reactivate", to: "subscriptions#reactivate", as: "reactivate_subscription"
  post "/episodes/new", to: "episodes#new", as: "add_episode"
end
