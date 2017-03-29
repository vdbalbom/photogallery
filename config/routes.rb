Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  root 'pages#home'
  get '/contributors', to: 'pages#contributors'
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

  get 'contributor/settings'
  patch 'contributor/settings', to: 'contributor#update_settings'
  get 'contributor/change_password'
  patch 'contributor/change_password', to: 'contributor#update_password'

  get 'admin/add_contributor', to: 'contributor#new', as: 'new_contributor'
  post 'admin/add_contributor', to: 'contributor#create'
  patch 'admin/add_contributor', to: 'contributor#create'
  get 'admin/delete_contributor/:contributor_id', to: 'contributor#remove',
                                                     as: 'remove_contributor'
  delete 'admin/delete_contributor/:contributor_id', to: 'contributor#delete'

  get '/login', to: 'contributor_session#new'
  post '/login', to: 'contributor_session#create'
  patch '/login', to: 'contributor_session#create'
  delete '/login', to: 'contributor_session#destroy'

  get 'gallery/photos', to: 'gallery#all_photos'
  get 'gallery/contributors/:contributor_id/photos',
       to: 'gallery#contributor_photos',
       as: 'contributor_photos'
  get 'gallery/tags/:tag_id/photos',
       to: 'gallery#tag_photos',
       as: 'tag_photos'
  get 'gallery/contributors/:contributor_id/tags/:tag_id/photos',
       to: 'gallery#contributor_tag_photos',
       as: 'contributor_tag_photos'

  get 'contributor/upload_photo', to: 'photos#new', as: 'upload_photo'
  post 'contributor/upload_photo', to: 'photos#create'
  patch 'contributor/upload_photo', to: 'photos#create'
  get 'gallery/photos/:photo_id', to: 'photos#show', as: 'show_photo'
  delete 'gallery/photos/:photo_id', to: 'photos#delete'
  get 'gallery/photos/:photo_id/edit', to: 'photos#edit', as: 'edit_photo'
  patch 'gallery/photos/:photo_id/edit', to: 'photos#update'

  get 'contributor/create_post', to: 'post#new', as: 'new_post'
  post 'contributor/create_post', to: 'post#create'
  patch 'contributor/create_post', to: 'post#create'
  get 'posts/:post_id', to: 'post#show', as: 'show_post'

  get 'post/edit'


end
