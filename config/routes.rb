Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  root 'pages#home'

  get 'photos',
        to: 'photos#index',
        as: 'all_photos'
  get 'photos/:photo_id/show',
        to: 'photos#show',
        as: 'show_photo'
  get 'photos/:photo_id/edit',
        to: 'photos#edit',
        as: 'edit_photo'
  delete 'photos/:photo_id',
        to: 'photos#delete'
  patch 'photos/:photo_id/edit',
        to: 'photos#update'
  get 'photos/new',
        to: 'photos#new',
        as: 'new_photo'
  post 'photos/new',
        to: 'photos#create'
  patch 'photos/new',
        to: 'photos#create'

  get '/contributors',
        to: 'contributors#index'
  get 'contributors/:contributor_id/photos/',
        to: 'contributors#photos',
        as: 'contributor_photos'
  get 'contributors/:contributor_id/tags/:tag_id/photos/',
        to: 'contributors#tag_photos',
        as: 'contributor_tag_photos'
  get 'contributors/:contributor_id/tags/',
        to: 'contributors#tags',
        as: 'contributor_tags'

  get '/tags',
        to: 'tags#index',
        as: 'all_tags'
  get 'tags/:tag_id/photos',
        to: 'tags#photos',
        as: 'tag_photos'

  get '/posts',
        to: 'posts#index',
        as: 'all_posts'
  get 'posts/new',
        to: 'posts#new',
        as: 'new_post'
  post 'posts/new',
        to: 'posts#create'
  patch 'posts/new',
        to: 'posts#create'
  get 'posts/:post_id/show',
        to: 'posts#show',
        as: 'show_post'
  get 'posts/:post_id/edit',
        to: 'posts#edit',
        as: 'edit_post'
  post 'posts/:post_id/edit',
        to: 'posts#update'
  patch 'posts/:post_id/edit',
        to: 'posts#update'
  delete 'posts/:post_id/show',
        to: 'posts#delete',
        as: 'delete_post'



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

  get '/login', to: 'contributor_session#new', as: 'login'
  post '/login', to: 'contributor_session#create'
  patch '/login', to: 'contributor_session#create'
  delete '/login', to: 'contributor_session#destroy'


  get 'contributors/:contributor_id', to: 'contributors#show', as: "show_contributor"
  delete 'contributors/:contributor_id', to: 'contributors#delete', as: 'delete_contributor'


end
