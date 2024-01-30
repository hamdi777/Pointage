Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :employees do
    collection do 
      post :import
    end
  end
  
  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"
end
