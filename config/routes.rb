Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :orders do
    collection { post :import }
  end
  
  authenticated :user do
	  root "orders#index", as: "authenticated_root"
	end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

end
