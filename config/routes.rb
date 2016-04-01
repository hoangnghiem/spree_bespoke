Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :products, only: [] do
      get :bespoke_options, on: :member
      resources :bespoke_option_types do
        resources :bespoke_option_values
      end
    end
  end
end
