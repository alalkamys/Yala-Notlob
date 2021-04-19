Rails.application.routes.draw do

  # * Friends controller routes
  get "/friends/", to: "friends#index", as: "friends"
  post "/friends/", to: "friends#create"
  delete "/friends/:id", to: "friends#destroy"

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
