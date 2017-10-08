Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  root to: 'pages#home', as: 'root'
  get '/lobby/:id', to: 'pages#lobby', as: 'lobby'
  
  patch '/player', to: 'players#update', as: 'player'
  
  get '/game/:id', to: 'games#show', as: 'game'
  post '/game/new', to: 'games#create', as: 'new_game'
  post '/game/start', to: 'games#start', as: 'start'
  post '/game/resign', to: 'games#resign', as: 'resign'
  post '/game/move', to: 'games#move', as: 'move'
  # post '/game/ask', to: 'games#ask', as: 'ask'
end
