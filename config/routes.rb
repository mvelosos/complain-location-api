Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      get 'complains/search', to: 'complains#search'
      resources :complains, only: [:index, :show, :create]

    end
  end
end
