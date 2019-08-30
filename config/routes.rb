Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # match '/', to: 'login#new', via: :get

  # office hours and question routes
  resources :office_hours_session do
    resources :question
  end

  # admin routes
  resources :admin, only: %i[index edit]
  match '/home', to: 'home#join_queue', via: :post
  match '/course/:id', to: 'course#update', via: :post
  resources :course
  resources :enrollment, only: %i[show edit]
  match '/enrollment/:id/',to: 'enrollment#update', via: :post
  match '/enrollment/:id/new',to: 'enrollment#new', via: :get
  match '/enrollment/:id/create',to: 'enrollment#create', via: :post

  # Single Routes
  get '/about', to: 'home#about'
  get '/how_it_works', to: 'home#how_it_works'
  post 'admin/:id/update', to: 'admin#update', as: :update

  # this is all oauth routes
  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'home#index'
  root to: 'home#show'
end
