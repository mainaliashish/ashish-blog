Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# get '/', to: 'pages#home'
get '/about', to: 'pages#about'

root 'pages#home'

get 'signup', 		to: 'users#new'
get 'login',  		to: 'sessions#new'
post 'login', 		to: 'sessions#create'
delete 'logout',	to: 'sessions#destroy'
#post 'users', to: 'users#create'

resources :users, except: [:new]
resources :articles

end
