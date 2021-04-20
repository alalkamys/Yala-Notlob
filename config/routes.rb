Rails.application.routes.draw do

  # get 'groups/index'
  # get 'groups/new'
  # get 'groups/create'
  # get 'groups/destroy'
  # get 'groups/add_user'
  # get 'groups/create_user'
  # get 'groups/destroy_user'

  
  # * Friends controller routes without using resources

  # get "/friends/", to: "friends#index", as: "friends"
  # post "/friends/", to: "friends#create"
  # delete "/friends/:id", to: "friends#destroy", as: "friend"


  resources :friends
  resources :groups do
    get '/user', to: 'groups#add_user', as: 'add_user'
    post '/user', to:	'groups#create_user', as: 'create_user'
    delete '/user/:user_id', to: 'groups#destroy_user', as: 'destroy_user'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  authenticated :user do
    root "pages#home", as: "authenticated_root"
  end

  devise_scope :user do
    root "devise/sessions#new"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
