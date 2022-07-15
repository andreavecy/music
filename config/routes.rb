Rails.application.routes.draw do
  resources :tracks
  get '/tracks/artist/:artist_id', to: 'tracks#tracks_artist'
  get '/tracks/album/:album_id', to: 'tracks#tracks_album'
  resources :albums
  get '/albums/artist/:artist_id', to: 'albums#album_artist'
  resources :artists
  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
