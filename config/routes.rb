Rails.application.routes.draw do
  apipie
  root     'api#home'
  get      '/login',   to: 'sessions#new'
  post     '/login',   to: 'sessions#create'
  delete   '/logout',  to: 'sessions#destroy'

  get      '/students/all', to: 'students#show'
  get      '/students/best/:number', to: 'students#show'

  get      '/institutions/all', to: 'institutions#show'
  get      '/institutions/:institution_id/students/best/:number', to: 'students#show'

  resources :institutions, only: [:create, :show, :update, :destroy]
  resources :students, only: [:create, :show, :update, :destroy]

  get      '/institutions/:institution_id/students/all', to: 'students#show'
end
