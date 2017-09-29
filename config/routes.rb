Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home', as: 'root'
  get '/lobby/:id', to: 'pages#game_lobby', as: 'game_lobby'
end
