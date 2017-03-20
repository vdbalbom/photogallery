Rails.application.routes.draw do

  root 'pages#home'
  get '/contributors', to: 'pages#contributors'

  get 'admin/site_settings'
  patch 'admin/site_settings', to: 'admin#update_site'
  get 'admin/settings'
  patch 'admin/settings', to: 'admin#update_admin'

  get '/admin', to: 'admin_session#new'
  post '/admin', to: 'admin_session#create'
  delete '/admin', to: 'admin_session#destroy' 

  get 'contributor/settings'
  get 'contributor/change_password'

  get '/login', to: 'contributor_session#new'
  post '/login', to: 'contributor_session#create'
  delete '/login', to: 'contributor_session#destroy'
end
