Rails.application.routes.draw do
  root "welcome#index"
  namespace :api do
    namespace :v1 do
      resources :languages, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      # USER: index, show
      # no user ability to create or edit a language.
      # ADMIN: :index, :show, :new, :create, :edit, :update, :destroy
      # Admin do all

      resources :words, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      # USER: index, show
      # no user ability to create or edit a word.
      # ADMIN: :index, :show, :new, :create, :edit, :update, :destroy
      # Admin do all

      resources :translations, only: [:index, :show, :edit, :update, :destroy]
      # USER: index, show
      # no user ability to create or edit a translation.
      # ADMIN: :index, :show, :edit, :update, :destroy
      # Admin can't create translations. Only info from wiktionary.

      resources :users, only: [:index, :show]
      # ADMIN can only see and show a user. User is admin. Should only be one.

      post "/auth/login/", to: "auth#login"

      
      # Custom routes

      # NAMING
      # /search searches for something and takes 1 or more params
      # /get returns all.
      # /controller/get || /search /model/arguments

      # Used



      # create images
      get "/search/all_translations_by_area_img/:area/:word", to: "translations#find_all_translations_by_area_img"
      get "/search/all_etymologies_by_area_img/:area/:word", to: "translations#find_all_etymologies_by_area_img"
      get "/search/all_genders_by_area_img/:area/:word", to: "translations#find_all_genders_by_area_img"

      # searchers
      
      get "/words/search/definition/:word", to: "words#find_word_definition"
      # renamed above

      get "/languages/search/area/:area", to: "languages#find_all_languages_by_area"
      # renamed above
      
      get "/search/grouped_etymology/:word/:macrofamily", to: "translations#find_grouped_etymologies"
      # renamed above

      get "/translations/search/macrofamily/:macrofamily", to: "translations#find_all_translations_by_macrofamily"
      # renamed above
      get "/translations/search/language/:language", to: "translations#find_all_translations_by_language"
      # renamed above
      get "/translations/search/word/:word", to: "translations#find_all_translations_by_word"
      # renamed above
      get "/translations/search/gender/:word", to: "translations#find_all_translations_by_word_gender"
      # renamed above
      get "/translations/search/etymology/:word", to: "translations#find_etymology_containing"
      # renamed above
      get "/translations/search/area/:area/:word", to: "translations#find_all_translations_by_area"
      # renamed above
      # This above route does the "Search Translations by Area" page route.
      # It also gets the data for all 3 maps' tables. It gets everything that matches, even if it is not on the map.

      # below is the way to show ONLY what is on the map
      get "/translations/search/area_europe_map/:area/:word", to: "translations#find_all_translations_by_area_europe_map"
      # renamed above
      get "translations/get/seeds", to: "translations#seeds"
      # renamed above

      # helpers
      get "/languages/get/macrofamily_names", to: "languages#all_macrofamily_names"
       # renamed above
      get "languages/get/alphabet_names", to: "languages#all_alphabet_names"
       # renamed above
      get "/languages/get/area_names", to: "languages#all_area_names"
      # renamed above
      get "words/get/word_names", to: "words#all_word_names"
      # renamed above

      # counters
      get "/languages/get/languages_count", to: "languages#languages_count"
      # renamed above
      get "/translations/get/translations_count", to: "translations#translations_count"
      # renamed above
      get "/words/get/words_count", to: "words#words_count"
      # renamed above
    end
  end
end
