Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :test, only: %i[index]
      resources :users
      resources :diaries
      resources :schedules
      resources :partners do
        resources :applies
        resources :group_users
        member do
          get :join
          get :search
        end
      end
      resources :partner_approvals

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }

      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
