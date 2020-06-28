Rails.application.routes.draw do
  root "welcome#index"
  namespace :api do
    namespace :v1 do
      resources :languages, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      # all routes for languages
      resources :words, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      # no ability to update a word. This leads to bad data. 
      # Can create only.
      resources :translations, only: [:index, :show, :edit, :update, :destroy]
      # no user ability to create a translation. Only info from wiktionary. 
      # Can update.

      get "/search/translations/:word", to: "translations#search_all_translations_by_word"
      get "/search/gender/:word", to: "translations#find_all_genders"
      get "/search/etymology/:word", to: "translations#find_etymology_containing"
      get "/search/grouped_etymology/:word/:macrofamily", to: "translations#find_grouped_etymologies"

      get "/search/all_translations_by_macrofamily/:macrofamily", to: "translations#find_all_translations_by_macrofamily"
      get "/search/all_translations_by_language/:language", to: "translations#find_all_translations_by_language"

      get "/search/all_languages_by_area/:location", to: "languages#find_all_languages_by_area"

      # create maps
      get "/search/all_translations_by_area/:location/:word", to: "translations#find_all_translations_by_area"
      # only the above for now. This one route is good enough for the three maps. Displays all info in the table.

      # create images
      get "/search/all_translations_by_area_img/:location/:word", to: "translations#find_all_translations_by_area_img"  
      get "/search/all_etymologies_by_area_img/:location/:word", to: "translations#find_all_etymologies_by_area_img"
      get "/search/all_genders_by_area_img/:location/:word", to: "translations#find_all_genders_by_area_img"

      get "/search/word_definition/:word", to: "words#find_a_definition"
 
      # helpers
      get "/search/all_macrofamily_names", to: "languages#find_all_macrofamily_names"
      get "/search/all_word_names", to: "words#find_all_words"
      get "/search/all_alphabet_names", to: "languages#find_all_alphabets"
      get "/search/all_areas", to: "languages#find_all_areas"

      # counters
      get "/search/languages_count", to: "languages#languages_count"
      get "/search/words_count", to: "words#words_count"
      get "/search/translations_count", to: "translations#translations_count"
    end
  end
end
