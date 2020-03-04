Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :translations
      resources :languages
      resources :words
      get '/search/translation/:word', to: 'translations#find_all_translations'
      get '/search/gender/:word', to: 'translations#find_all_genders'
      get '/search/etymology/:word', to: 'translations#find_etymology_containing'
      get '/search/grouped_etymology/:word/:macrofamily', to: 'translations#find_grouped_etymologies'
      get '/search/all_by_macrofamily/:macrofamily', to: 'translations#all_languages_by_macrofamily'
      get '/search/grouped_etymology/:word/:macrofamily', to: 'translations#find_grouped_etymologies'

      get '/search/all_macrofamily_names', to: 'languages#find_all_macrofamily_names'
    end
  end
end

