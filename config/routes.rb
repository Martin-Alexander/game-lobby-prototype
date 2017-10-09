Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  root to: 'pages#home', as: 'root'
  get '/lobby/:id', to: 'pages#lobby', as: 'lobby'
  
  patch '/player', to: 'players#update', as: 'player'
  
  get '/game/:id', to: 'games#show', as: 'game'
  post '/game/new', to: 'games#create', as: 'new_game'
  post '/game/:id/start', to: 'games#start', as: 'start'
  post '/game/:id/resign', to: 'games#resign', as: 'resign'
  post '/game/:id/move', to: 'games#move', as: 'move'
  post '/game/:id/send_game_data', to: 'games#send_game_data', as: 'send_game_data'
  # post '/game/ask', to: 'games#ask', as: 'ask'
end
