Rails.application.routes.draw do
  resources :personality_traits
  
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :pledges

  resources :mansions do
  	resource :lounges, only: [:show]
  end

 	get 'mansions/:id/book', to: 'mansions#book', as: 'new_booking'
 	get 'mansions/:id/leave', to: 'mansions#leave', as: 'destroy_booking'

 	get 'users/:id', to: 'users#show', as: 'user'

 	post '/mansions/:id/bookings/create', to: 'bookings#create'

 	get '/mansions/:id/bookings/show', to: 'bookings#show', as: 'show_booking'
	
	root 'welcome#index'	

  mount Commontator::Engine => '/commontator'  

	get '/mansions/:id/lounge/:id', to: 'lounges#show', as: 'mansion_lounge'
end
