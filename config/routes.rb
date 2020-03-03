Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :translations
      resources :languages
      resources :words
      get '/search/etymology/:word', to: 'translations#find_all_translations', as: 'find_translations_path'
      get '/search/gender/:word', to: 'translations#find_all_genders', as: 'find_genders_path'
      get '/search/:word', to: 'translations#search', as: 'search_path'
    end
  end
end

