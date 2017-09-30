Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  root to: 'pages#home', as: 'root'
  get '/lobby/:id', to: 'pages#game_lobby', as: 'game_lobby'
  post '/change_role', to: 'pages#change_role', as: 'change_role'
end
