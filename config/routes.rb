Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:index]
  post 'goals/:id/complete' => 'goals#complete', as: 'complete_goal'

  resources :comments, only: [:create, :destroy]
end
