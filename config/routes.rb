Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users do
    resources :reviews
  end
  resources :events
  resources :partners
  root to: "pages#home"
end
