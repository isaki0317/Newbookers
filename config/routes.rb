Rails.application.routes.draw do
  
  get 'home/about' => 'homes#about'
  root to: 'homes#top'
  devise_for :users

  resources :users, only: [:index, :show, :edit, :create, :update]
  
  resources :books

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
