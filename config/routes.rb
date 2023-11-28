Rails.application.routes.draw do
  get 'users/show'
  get 'search', to: 'search#index'
  # get 'home/index'
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  # resources :user
  # resources :users, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "blogs#index"

  root to: "home#index" 


  resources :blogs do
    collection do
      get 'user_blogs', to: 'blogs#user_blogs', as: 'current_user_blogs'
    end
  end
  # root "blogs#index"
  resources :blogs do 
    resources :comments
  end  

  # get "/blogs", to: "blogs#index"
  # get "/blogs/:id", to: "blogs#show"
  # get "blogs/index"
  # get "blogs/show"
end