Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:update]

  resources :users, only: [:update] do
  	post "downgrade"
  	get "downgrade"
  end

  resources :wikis

  resources :charges, only: [:new, :create]
 
  root to: 'welcome#index'

end
