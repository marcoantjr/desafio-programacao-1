Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :orders, only: [:index, :show, :destroy] do
    collection { post :import }
  end
  
  authenticated :user do
	  root "orders#index", as: "authenticated_root"
	end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get '*unmatched_route', to: 'application#not_found'

end
