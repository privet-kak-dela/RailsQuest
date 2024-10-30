Rails.application.routes.draw do
   root 'characters#index'

   resources :characters, only: [:index, :create] do
      post :ultimate, on: :collection
   end

   resources :games do
      post :restart, on: :collection
      post :generate, on: :collection
   end
end
