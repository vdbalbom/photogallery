Rails.application.routes.draw do

  get 'admin', to: 'admin#login'

  root 'pages#home'
  get '/contributors', to: 'pages#contributors'

  get 'admin/settings'
  get 'admin/change_password'

  get 'contributor/settings'
  get 'contributor/change_password'
end
