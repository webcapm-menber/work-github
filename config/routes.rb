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
    get 'admin/homes/index/:id',to: 'homes#index'
    resources :items, only: [:new, :index, :create, :show, :edit, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    #以下の内容でも
    # resources :customers, only: %i[index show edit update]
  end

  scope module: :customer do
    root to: "homes#top"
    get 'homes/about'
    # resource :customers, only: %i[show edit update] do
    #   collection do
    #     get 'unsubscribe'
    #     patch 'withdrawal'
    #   end
    # end
    get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal', to: 'customers#withdrawal', as: 'withdrawal'
    get 'customers/show', to: 'customers#show'
    get 'customers/edit_information', to: 'customers#edit'
    patch 'customers/update', to: 'customers#update'
    resources :items, only: [:index, :show, :create]
    resources :cart_items, only: %i[index update destroy create] do
      delete 'destroy_all', on: :collection
    end
    resources :shipping_addresses, only: %i[index create edit update destroy]
    resources :orders, only: %i[new index create show] do
      collection do
        get 'check'
        get 'completed'
      end
    end
  end

  resources :genres, only: [:index, :create, :edit, :update ]

end
