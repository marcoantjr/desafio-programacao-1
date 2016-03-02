Rails.application.routes.draw do

  resources :orders do
    collection { post :import }
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'orders#index'

end
