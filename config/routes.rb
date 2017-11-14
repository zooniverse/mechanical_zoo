Rails.application.routes.draw do
  get 'classify/start'
  get 'classify/callback/:id', to: 'classify#callback'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
