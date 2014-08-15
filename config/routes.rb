Rails.application.routes.draw do
  devise_for :users
  resources :pledges
  resources :mansions


	root 'welcome#index'	
end
