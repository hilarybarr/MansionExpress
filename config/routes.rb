Rails.application.routes.draw do
  resources :personality_traits

  resources :pledges
  resources :mansions


	root 'welcome#index'	
end
