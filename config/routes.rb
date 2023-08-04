Rails.application.routes.draw do

  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get root to: 'homes#top'
    get 'homes/about'
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    #以下の内容でも
    # resources :customers, only: %i[index show edit update]
  end

  namespace :public do
    root to: "homes#top"
    get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal', to: 'customers#withdrawal', as: 'withdrawal'
    get 'customers/show', to: 'customers#show'
    get 'customers/edit', to: 'customers#edit'
    patch 'customers/update', to: 'customers#update'
  end

  scope module: :customer do
    resources :items, only: [:index, :show]
    resources :shipping_addresses, only: %i[index create edit update destroy]
  end
  
  resources :genres, only: [:index, :create, :edit, :update ]

end
