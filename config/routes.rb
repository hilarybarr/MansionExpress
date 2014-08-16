Rails.application.routes.draw do

  resources :personality_traits
  
  devise_for :users
  resources :pledges
  resources :mansions

 	get 'mansions/:id/book', to: 'mansions#book', as: 'new_booking'
 	get 'mansions/:id/leave', to: 'mansions#leave', as: 'destroy_booking'

 	get 'users/:id', to: 'users#show', as: 'user'

	root 'welcome#index'	
end
