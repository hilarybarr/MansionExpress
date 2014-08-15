Rails.application.routes.draw do
  resources :pledges
  resources :mansions
  resources :identities

	root 'welcome#index'	
end
