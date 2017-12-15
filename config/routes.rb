Rails.application.routes.draw do
  root 'sessions#index'

  post 'session/new' => 'sessions#create'

  delete 'session/logout' => 'sessions#destroy'

  get 'events' => 'events#index'

  post 'events/new' => 'events#create'

  get 'events/:id' => 'events#show'

  post 'events/:id' => 'events#comment'
  
  patch 'events/:id' => 'events#join'
  
  delete 'events/:id' => 'events#destroy'
  
  get 'events/:id/edit' => 'events#edit'

  patch 'events/:id/edit' => 'events#update'
  
  get 'user/:id' => 'users#edit'

  patch 'user/:id' => 'users#update'

  post 'user/new' => 'users#create'

end
