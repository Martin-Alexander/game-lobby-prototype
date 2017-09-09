Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#main', as: 'root'
  post '/update', to: 'pages#update', as: 'update'
end
