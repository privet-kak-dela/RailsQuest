Rails.application.routes.draw do
   root 'home#index'
   post '/new_character', to: 'home#new_сharacter'
   post '/ultimate', to: 'home#ultimate'
   post '/restart', to: 'home#restart'
   post '/generate_game', to: 'home#generate_game'
end
