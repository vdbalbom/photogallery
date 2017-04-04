Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  root 'pages#home'
  get '/contributors', to: 'contributors#index'
  get '/posts', to: 'pages#posts'
  get '/all_tags', to: 'pages#tags'

  get 'admin/site_settings'
  patch 'admin/site_settings', to: 'admin#update_site'
  get 'admin/settings'
  patch 'admin/settings', to: 'admin#update_admin'

  get '/admin', to: 'admin_session#new'
  patch '/admin', to: 'admin_session#create'
  post '/admin', to: 'admin_session#create'
  delete '/admin', to: 'admin_session#destroy'

  get 'contributor/settings', to: 'contributors#settings'
  patch 'contributor/settings', to: 'contributors#update_settings'
  get 'contributor/change_password', to: 'contributors#settings'
  patch 'contributor/change_password', to: 'contributors#update_password'

  get 'admin/add_contributor', to: 'contributors#new', as: 'new_contributor'
  post 'admin/add_contributor', to: 'contributors#create'
  patch 'admin/add_contributor', to: 'contributors#create'

  get '/login', to: 'contributor_session#new'
  post '/login', to: 'contributor_session#create'
  patch '/login', to: 'contributor_session#create'
  delete '/login', to: 'contributor_session#destroy'

  get '/photos', to: 'gallery#all_photos'
  get '/contributors/:contributor_id/photos',
       to: 'gallery#contributor_photos',
       as: 'contributor_photos'
  get '/tags/:tag_id/photos',
       to: 'gallery#tag_photos',
       as: 'tag_photos'
  get '/contributors/:contributor_id/tags/:tag_id/photos',
       to: 'gallery#contributor_tag_photos',
       as: 'contributor_and_tag_photos'
       get '/contributors/:contributor_id/tags',
            to: 'contributors#tags',
            as: 'contributor_tags'

  get 'contributor/upload_photo', to: 'photos#new', as: 'upload_photo'
  post 'contributor/upload_photo', to: 'photos#create'
  patch 'contributor/upload_photo', to: 'photos#create'
  get 'photos/:photo_id', to: 'photos#show', as: 'show_photo'
  delete 'photos/:photo_id', to: 'photos#delete'
  get 'photos/:photo_id/edit', to: 'photos#edit', as: 'edit_photo'
  patch 'photos/:photo_id/edit', to: 'photos#update'

  get 'contributor/create_post', to: 'posts#new', as: 'new_post'
  post 'contributor/create_post', to: 'posts#create'
  patch 'contributor/create_post', to: 'posts#create'
  get 'posts/:post_id', to: 'posts#show', as: 'show_post'

  get 'contributors/:contributor_id', to: 'contributors#show', as: "show_contributor"
  delete 'contributors/:contributor_id', to: 'contributors#delete', as: 'delete_contributor'

  get 'posts/edit'


end
