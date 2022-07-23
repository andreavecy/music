Rails.application.routes.draw do
  resources :follows
  resources :favorite_tracks
  get '/user_favorites/:user_id', to: 'favorite_tracks#user_favorites'
  get '/track_user_favorites/:track_id', to: 'favorite_tracks#track_user_favorites'
  resources :tracks
  post '/search_track', to: 'tracks#search_track'
  get '/tracks/artist/:artist_id', to: 'tracks#tracks_artist'
  get '/tracks/album/:album_id', to: 'tracks#tracks_album'
  resources :albums
  get '/albums/artist/:artist_id', to: 'albums#album_artist'
  resources :artists
  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/update/:id', to: 'registrations#update_user'
    post '/login', to: 'sessions#create'
    get '/current_user/:id', to: 'sessions#get_user'
    delete '/logout', to: 'sessions#destroy'
  end
  post '/follow/:id', to: "follows#follow", as: "follow_user"
  post '/unfollow/:id', to: "follows#unfollow", as: "unfollow_user"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
