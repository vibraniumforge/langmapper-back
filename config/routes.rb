Rails.application.routes.draw do
  resources :translations
  resources :languages
  namespace :api do
    namespace :v1 do
      resources :words
            end
  end
end

