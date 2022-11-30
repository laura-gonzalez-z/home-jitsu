Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users do
    resources :reviews
  end

  get "my_events", to: "events#my_events"

  resources :events

  resources :guests, only: %i[create destroy]

  resources :partners
  resources :chatrooms, only: %i[show create] do
    resources :messages, only: :create
  end

  root to: "pages#home"
  get "my_messages", to: "chatrooms#my_messages"
  patch "/partners/:id/accept", to: "partners#accept", as: :accept
  patch "/partners/:id/reject", to: "partners#reject", as: :reject
end
