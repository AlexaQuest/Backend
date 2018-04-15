Rails.application.routes.draw do
  match '/game', to: 'game#game', via: :all
  match '/alexa', to: 'game#alexa', via: :all

  root 'home#index'
end
