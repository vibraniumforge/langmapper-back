Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :translations
      resources :languages
      resources :words
      get '/search/:word', to: 'translations#search', as: 'search_path'
    end
  end
end

