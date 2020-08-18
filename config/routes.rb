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

      post "/auth/login", to: "auth#login"
      post "/auth", to: "application#authorized"
      # above needs to go outside api/v1 namespace.

      get "/words/translation_seeds_test", to: "words#translation_seeds_test"
      
      # Custom routes

      # NAMING
      # /search searches for something and takes 1 or more params
      # /get returns all.
      # /controller/get || /search /model/arguments

      # Used

      # create images
      get "/translations/search/all_translations_by_area_img/:area/:word", to: "translations#find_all_translations_by_area_img"
      get "/translations/search/all_etymologies_by_area_img/:area/:word", to: "translations#find_all_etymologies_by_area_img"
      get "/translations/search/all_genders_by_area_img/:area/:word", to: "translations#find_all_genders_by_area_img"

      # below is the way to show ONLY what is on the first Europe map
      get "/translations/search/area_europe_map/:area/:word", to: "translations#find_all_translations_by_area_europe_map"
 
      # searchers
      
      get "/words/search/definition/:word", to: "words#find_word_definition"

      get "/languages/search/area/:area", to: "languages#find_all_languages_by_area"

      get "/translations/search/macrofamily/:macrofamily", to: "translations#find_all_translations_by_macrofamily"
      get "/translations/search/language/:language", to: "translations#find_all_translations_by_language"
      get "/translations/search/word/:word", to: "translations#find_all_translations_by_word"
      get "/translations/search/gender/:word", to: "translations#find_all_translations_by_word_gender"
      get "/translations/search/etymology/:word", to: "translations#find_etymology_containing"
      get "/translations/search/area/:area/:word", to: "translations#find_all_translations_by_area"
      # This above route does the "Search Translations by Area" page route.
      # It also gets the data for all 3 maps' tables. It gets everything that matches, even if it is not on the map.

      get "/translations/get/seeds", to: "translations#seeds"

      # helpers for selects
      get "/languages/get/macrofamily_names", to: "languages#all_macrofamily_names"
      get "/languages/get/alphabet_names", to: "languages#all_alphabet_names"
      get "/languages/get/area_names", to: "languages#all_area_names"

      get "/words/get/word_names", to: "words#all_word_names"

      # counters
      get "/languages/get/languages_count", to: "languages#languages_count"
      get "/translations/get/translations_count", to: "translations#translations_count"
      get "/words/get/words_count", to: "words#words_count"

    end
  end
end
