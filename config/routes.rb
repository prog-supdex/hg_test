Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events, except: :edit
  get '/', to: 'events#index', as: :root
end
