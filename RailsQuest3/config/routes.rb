Rails.application.routes.draw do
   root 'home#index'
   post '/new_character', to: 'home#new_сharacter'
   post '/ulta1_activate', to: 'home#ulta1_activate'
   post '/ulta2_activate', to: 'home#ulta2_activate'
   post '/restart', to: 'home#restart'
   post '/generate_game', to: 'home#generate_game'
end
