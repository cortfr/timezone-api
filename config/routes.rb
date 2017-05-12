Rails.application.routes.draw do
  get 'pages/index'
  post 'zipcodes/find'

  root 'pages#index'
end
