Rails.application.routes.draw do
  get 'mansions/index'

  resources :pledges
  resources :mansions
  resources :identities
end
