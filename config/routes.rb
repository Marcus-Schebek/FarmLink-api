Rails.application.routes.draw do
  get "users/create"
  resources :animal_diets
  resources :applications
  resources :heats
  resources :symptoms
  resources :sales
  resources :animals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Autenticação
  post   "/signup", to: "users#create"     # criar conta
  post   "/login",  to: "sessions#create"  # login
  delete "/logout", to: "sessions#destroy" # logout
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Lotes
  resources :lots
   # Medicamentos
  resources :medicines

  # Dietas
  resources :diets

  # Animais e sub-recursos
  resources :animals do
    resources :symptoms, only: [:index, :create, :update, :destroy]
    resources :heats, only: [:index, :create, :update, :destroy]
    resources :applications, only: [:index, :create, :update, :destroy]
    resources :animal_diets, only: [:index, :create, :update, :destroy]
  end

  # Vendas
  resources :sales do
    post "add_animal/:animal_id", to: "sales#add_animal", on: :member
    delete "remove_animal/:animal_id", to: "sales#remove_animal", on: :member
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
