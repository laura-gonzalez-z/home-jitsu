Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users do
    resources :reviews
  end

  resources :events

  resources :guests, only: %i[create]

  resources :partners, only: %i[index create destroy]

  resources :chatrooms, only: %i[show create] do
    resources :messages, only: :create
  end

  root to: "pages#home"

  get "my_messages", to: "chatrooms#my_messages"

  get "my_events", to: "events#my_events"

  get "notifications", to: "notifications#index"

  get "invite_partners", to: "partners#invite_partners_list"

  patch "/partners/:id/accept", to: "partners#accept", as: :accept
  patch "/partners/:id/reject", to: "partners#reject", as: :reject

  patch "/guests/:id/accept", to: "guests#accept", as: :accept_guest
  patch "/guests/:id/reject", to: "guests#reject", as: :reject_guest

  post "/guests", to: "guests#invite", as: :invite
end
