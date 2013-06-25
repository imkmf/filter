Filter::Application.routes.draw do
  root 'high_voltage/pages#show', id: 'home'
  get "utilities/hello"
  get '/auth/:provider/:callback', to: 'sessions#create'
  get "/signout" => "sessions#destroy", :as => :signout
  resources :podcasts
end
