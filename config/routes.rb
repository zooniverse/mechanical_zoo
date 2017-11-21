Rails.application.routes.draw do
  resource :session

  resources :classify do
    collection do
      get :start
    end

    member do
      get :callback
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
