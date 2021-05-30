Rails.application.routes.draw do
  root 'pages#home'

  resources :reservations, only: [:index, :new, :create, :show, :destroy] do
    collection do
      post 'confirm_new'
    end
  end

  resources :rooms, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end

  devise_for :users,
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  devise_scope :user do
    get 'show' => 'users/registrations#show'
    get 'account_edit' => 'users/registrations#account_edit'
    put 'account_update' => 'users/registrations#account_update'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
