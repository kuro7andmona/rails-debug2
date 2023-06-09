Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get 'home/about'=>'homes#about', as: 'about'
  post 'books' => 'books#create'


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update,:new] do

   resources :book_comments, only: [:create, :destroy]
   resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update]
  get 'search' => 'searches#search'

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers' , as: 'followers'
  end
  #get 'search' => 'searches#search'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end