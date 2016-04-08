Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :products, only: [] do
      get :bespoke_options, on: :member
      resources :bespoke_option_types do
        post :update_positions, on: :collection
        resources :bespoke_option_values do
          post :update_positions, on: :collection
        end
      end
    end
  end
end
