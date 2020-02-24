Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :words
      resources :translations
      resources :languages
    end
  end
end

