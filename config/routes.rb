Rails.application.routes.draw do

  resources :personality_traits


  devise_for :users
  resources :pledges
  resources :mansions


	root 'welcome#index'	
end
