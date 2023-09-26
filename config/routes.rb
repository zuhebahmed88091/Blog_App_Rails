Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments ,only:[:index,:new,:create]
    end
  end
  
  root 'users#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
