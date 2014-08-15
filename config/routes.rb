Rails.application.routes.draw do
  resources :pledges
  resources :mansions


	root 'welcome#index'	
end
