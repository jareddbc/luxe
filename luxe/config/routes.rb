Rails.application.routes.draw do


  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "hotels#new", :as => "sign_up"

  resources :hotels
  resources :sessions

  root "visitors#index"

end
