Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  get 'pages/index'
  root 'pages#index'
  
  #resources :searches
  get 'searches/show', to: 'searches#show'
  get 'searches/index', to: 'searches#index'
  post '/searches/index', to: 'searches#create'
  
  resources :community_participants, only: [:index, :create, :update, :destroy]
  
  #get 'users/new_manager'
  
  resources :users
  patch '/users', to: 'users#update'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :invitations, except: [:show]
  
  resources :communities, except: [:show, :update, :destroy] do
    member do
      get '/events', to: 'events#index'
    end  
  end
  
  get 'communities/community_show', to: 'communities#community_show'
  get 'communities/community_edit', to: 'communities#community_edit'
  patch '/communities', to: 'communities#update'
  delete '/communities/:id',  to: 'communities#destroy'
  
  #resources :channels, except: [:show]
  get 'channels/channel_change', to: 'channels#channel_change'
  get 'channels/channel_show', to: 'channels#channel_show'
  get 'channels/channel_edit', to: 'channels#channel_edit'
  patch '/channels', to: 'channels#update'
  delete '/channels/:id',  to: 'channels#destroy'
  
  resources :gthreads, except: [:index, :show]
  
  resources :channels, param: :channel_id, except: [:show, :update, :destroy] do
    member do
      resources :gthreads, only: [:index], as: :channels_gthreads, param: :g_uid
      get 'gthreads/:g_uid', to: 'gthreads#index' #2021/7/9追記 リアクション、コメントモーダル用
    end  
  end
  
  get '/show_additionally', to: 'gthreads#show_additionally'
  get 'gthreads/notification_index', to: 'gthreads#notification_index', as: :gthreads_notification_index
  get 'gthreads/reaction_image_index', to: 'gthreads#reaction_image_index', as: :gthreads_reaction_image_index
  get 'gthreads/comment_index', to: 'gthreads#comment_index', as: :gthreads_comment_index
  get 'gthreads/test', to: 'gthreads#test'
  
  resources :events, only: [:new, :create], param: :community_id
  
  get 'schedules/index', to: 'schedules#index'
  
  resources :thread_reactions, only: [:create, :destroy], param: :entity_name
  resources :comments
  
  resources :notifications, only: :update
  get '/unchecked_notifications_present_check', to: 'notifications#unchecked_notifications_present_check'
  
  get 'tests/test1'
  get 'tests/test2'
  get 'tests/amoeba'
  get 'tests/jsidemenu'
end
