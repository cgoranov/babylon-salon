Rails.application.routes.draw do

  root 'welcome#home'

  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
