Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#main', as: 'root'
  post '/update', to: 'pages#update', as: 'update'
  post '/join_game', to: 'pages#join_game', as: 'join_game'
  post '/leave_lobby', to: 'pages#leave_lobby', as: 'leave_lobby'
end
