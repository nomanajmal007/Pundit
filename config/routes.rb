Rails.application.routes.draw do
  devise_for :users, path: '',path_names: { sign_in: 'login',sign_out:'logout',sign_up:'register' }
  resources :portfolios, except: [:show]
  resources :users
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'

  get 'angular-items', to: 'portfolios#angular'
  get 'rubyonrails-items', to: 'portfolios#rubyonrails'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  resources :stories do
    member do
      get :toggle_status
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  
end
