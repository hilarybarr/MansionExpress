Rails.application.routes.draw do

  resources :personality_traits
  
  devise_for :users
  resources :pledges
  resources :mansions

 	get 'mansions/:id/book', to: 'mansions#book', as: 'new_booking'
 	get 'mansions/:id/leave', to: 'mansions#leave', as: 'destroy_booking'

 	get 'users/:id', to: 'users#show', as: 'user'

 	post '/mansions/:id/bookings/create', to: 'bookings#create'

 	get '/mansions/:id/bookings/show', to: 'bookings#show', as: 'show_booking'
	
	root 'welcome#index'	
end
