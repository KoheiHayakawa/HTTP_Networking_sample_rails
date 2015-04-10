Rails.application.routes.draw do

  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :entries, only: [:index, :show, :create, :update, :destroy]
      
    post 'users/sign_up', to: 'users#sign_up'
    post 'users/sign_in', to: 'users#sign_in'
    end
  end

  match '*path' => 'api#error404', via: :all
end
