Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  resources :articles
  get 'signup', to: 'users#new' #define the path of url, set signup to replace users/new
  resources :users, except: [:new]#solve error undefined method 'users_path', or type "post 'users', to: 'users#create'"
  #except new means the new html has been assigned to signup
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :tags, except: [:destroy]
  #get 'allComments', to: 'users#list_comment'
  #get 'comments', to: 'comments#new'
  #post 'comments', to: 'comments#create'
  resources :comments

  
end
