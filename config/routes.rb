Rails.application.routes.draw do
  match '/game', to: 'game#alexa', via: :all

  root 'home#index'
end
