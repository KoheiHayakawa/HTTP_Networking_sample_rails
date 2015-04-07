Rails.application.routes.draw do

  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :entries, only: [:index, :show, :create, :update, :destroy]
    end
  end

  match '*path' => 'api#error404', via: :all
end
