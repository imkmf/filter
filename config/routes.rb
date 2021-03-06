Filter::Application.routes.draw do
  root "pages#front"
  resources :podcasts, except: [:index]
  resources :episodes do
    post :sort, on: :collection
  end
  resources :subscriptions
  resources :users, only: [:edit, :update]
  get '/help', to: "pages#help"
  get "/utilities/hello"
  get "/auth/:provider/:callback", to: "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/my_podcast", to: "podcasts#show"
  get "/my_podcast/publish", to: "podcasts#publish", as: "publish_podcast"
  post "/users/remove_card", to: "subscriptions#remove_card", as: "remove_card"
  post "/subscriptions/reactivate", to: "subscriptions#reactivate", as: "reactivate_subscription"
  post "/subscriptions/validate_coupon", to: "subscriptions#validate_coupon", as: "validate_coupon"
  post "episodes/blacklist", to: "episodes#blacklist", as: "blacklist_episode"
  mount Resque::Server, :at => "/resque" if Rails.env.development?
  mount StripeEvent::Engine => "/stripe_events"
end
