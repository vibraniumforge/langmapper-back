Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :translations
      resources :languages
      resources :words
    end
  end
end
