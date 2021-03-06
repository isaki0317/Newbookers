Rails.application.routes.draw do
  
  get 'relationships/create'
  get 'relationships/destroy'
  get 'home/about' => 'homes#about'
  root to: 'homes#top'
  devise_for :users
  
  # 簡単ログイン機能実装
  post '/homes/guest_sign_in', to: 'homes#new_guest'
  # 簡単ログイン機能ここまで
  get 'follows_books' => 'users#follows_book'
  resources :users, only: [:index, :show, :edit, :create, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    get :search, on: :collection
  end
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  #通知機能
  resources :notifications, only: :index do
    collection do
      delete 'destroy_all'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
