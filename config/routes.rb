Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  root to: 'pages#home', as: 'root'
  get '/lobby/:id', to: 'pages#game_lobby', as: 'game_lobby'
  post '/change_role', to: 'pages#change_role', as: 'change_role'
  post '/create_game', to: 'pages#create_game', as: 'create_game'
  get '/game/:id', to: 'pages#game', as: 'game'
  post '/start_game', to: 'pages#start_game', as: 'start_game'
  post '/resign', to: 'pages#resign', as: 'resign'
end
