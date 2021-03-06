Rails.application.routes.draw do
  resource :session
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :classify do
    collection do
      get :start
    end

    member do
      get :callback
    end
  end

  resources :projects do
    resources :workflows
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
