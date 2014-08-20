Rails.application.routes.draw do
  resources :personality_traits
  

  devise_for :users
  resources :pledges


  resources :comments
  resources :mansions do
  	resource :lounges, only: [:show]
  end

 	get 'mansions/:id/book', to: 'mansions#book', as: 'new_booking'
 	get 'mansions/:id/leave', to: 'mansions#leave', as: 'destroy_booking'

 	get 'users/:id', to: 'users#show', as: 'user'

 	post '/mansions/:id/bookings/create', to: 'bookings#create'

 	get '/mansions/:id/bookings/show', to: 'bookings#show', as: 'show_booking'

 	# get '/mansions/:id/lounge', to: 'mansions#lounge'
	
	root 'welcome#index'	

	get '/mansions/:id/lounge/:id', to: 'lounges#show'
end
