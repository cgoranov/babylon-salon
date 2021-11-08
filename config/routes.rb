Rails.application.routes.draw do

  
  root 'welcome#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'


  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

  resources :barbers
  
  resources :users do 
    resources :appointments
    resources :barbers, only: [:index]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
