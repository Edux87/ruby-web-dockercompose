Rails.application.routes.draw do
  get 'application/home'
  resources :categoria
  resources :productos
  devise_for :users
  # devise_for :users, controllers: {registrations: 'registrations'}
  root "application#home"
  
  
  unauthenticated do
     root :to => 'application#home'
  end

  authenticated do
    root :to => 'intranet#home'
  end
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
