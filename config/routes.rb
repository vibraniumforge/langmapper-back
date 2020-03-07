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
      get '/search/all_translations_by_macrofamily/:macrofamily', to: 'translations#find_all_translations_by_macrofamily'
      get '/search/all_translations_by_language/:language', to: 'translations#find_all_translations_by_language'

      get '/search/all_macrofamily_names', to: 'languages#find_all_macrofamily_names'
      get '/search/all_word_names', to: 'words#find_all_word_names'
    end
  end
end

