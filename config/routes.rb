Collect::Application.routes.draw do
  
  resources :posts
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :users do
    member do
      get :following, :followers
    end
    resources :messages
  end

  resources :relationships, only: [:create, :destroy]
  resources :collections, only: [:create,:update, :destroy]
  resources :albums

  #get "welcome/index"

  root 'welcome#index'
  #STATIC PAGES
  match '/help',      to: 'welcome#help',     via: 'get'
  match '/about',     to: 'welcome#about',    via: 'get'
  match '/contact',   to: 'welcome#contact',  via: 'get'
  match '/admin',     to: 'welcome#admin',    via: 'get'
  #USER
  match '/signup',    to: 'users#new',        via: 'get'
  match '/signin',    to: 'sessions#new',     via: 'get'
  match '/signout',   to: 'sessions#destroy', via: 'delete'

end
