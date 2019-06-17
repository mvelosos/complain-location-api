Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      get 'complains/search',       to: 'complains#search'
      get 'complains/coordinates',  to: 'complains#coordinates'
      get 'complains/:id/localization', to: 'complains#localization'
      resources :complains, only: [:index, :show, :create]

    end
  end
end
