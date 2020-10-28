Rails.application.routes.draw do
  
  get 'relationships/create'
  get 'relationships/destroy'
  get 'home/about' => 'homes#about'
  root to: 'homes#top'
  devise_for :users
  
  # 簡単ログイン機能実装
  post '/homes/guest_sign_in', to: 'homes#new_guest'

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
