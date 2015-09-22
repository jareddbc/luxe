Rails.application.routes.draw do


  get '/login' => 'sessions#hotel'
  post '/login' => 'sessions#create'

  get '/' => 'sessions#guest'
  post '/' => 'sessions#create'

  get '/calendar' => 'hotels#calendar'

  get '/incoming/:key' => 'sessions#create'
  post '/incoming' => 'sessions#create'

  get '/logout' => 'sessions#destroy'
  get '/signup' => 'hotels#new'
  post '/hotels' => 'hotels#create'
  get '/hotels/:id' => 'hotels#show'
  post '/hotels/show' => 'hotels#show'
  get '/hotel_logout' => 'hotels#destroy'
  # get "log_out" => "sessions#destroy", :as => "log_out"
  # get "log_in" => "sessions#new", :as => "log_in"
  # get "sign_up" => "hotels#new", :as => "sign_up"

  resources :guests
  resources :sessions
  resources :hotels
  resources :services
  resources :menu

  root "sessions#guest"

  namespace :api do
    resources :services, :only => [:create]
  end

end
