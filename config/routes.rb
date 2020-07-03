Rails.application.routes.draw do
  root "welcome#index"
  namespace :api do
    namespace :v1 do
      resources :languages, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      # USER: index show
      # no user ability to create or edit a language.
      # ADMIN: :index, :show, :new, :create, :edit, :update, :destroy
      # Admin do all

      resources :words, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      # USER: index show
      # no user ability to create or edit a word.
      # ADMIN: :index, :show, :new, :create, :edit, :update, :destroy
      # Admin do all

      resources :translations, only: [:index, :show, :edit, :update, :destroy]
      # USER: index show
      # no user ability to create or edit a translation.
      # ADMIN: :index, :show, :edit, :update, :destroy
      # Admin can't create. Only info from wiktionary.

      # Custom routes

      # NAMING
      # /search searches for something and takes 1 or more params
      # /get returns all.
      # /get || /search /controller/method to

      # create images
      get "/search/all_translations_by_area_img/:location/:word", to: "translations#find_all_translations_by_area_img"
      get "/search/all_etymologies_by_area_img/:location/:word", to: "translations#find_all_etymologies_by_area_img"
      get "/search/all_genders_by_area_img/:location/:word", to: "translations#find_all_genders_by_area_img"

      # REFACTORED BELOW HERE

      # Not used in program

      # get "/search/translations/translations_by_macrofamily/:macrofamily", to: "translations#find_all_translations_by_macrofamily"
      # get "/search/grouped_etymology/:word/:macrofamily", to: "translations#find_grouped_etymologies"

      # Used

      # searchers
      get "/search/words/definition/:word", to: "words#find_word_definition"

      get "/search/languages/area/:area", to: "languages#find_all_languages_by_area"

      get "/search/translations/language/:language", to: "translations#find_all_translations_by_language"
      get "/search/translations/word/:word", to: "translations#find_all_translations_by_word"
      get "/search/translations/gender/:word", to: "translations#find_all_translations_by_gender"
      get "/search/translations/etymology/:word", to: "translations#find_etymology_containing"
      get "/search/translations/area/:area/:word", to: "translations#find_all_translations_by_area"
      # This route does the "Search Translations by Area" route.
      # It also gets the data for all 3 maps's tables

      # helpers
      get "/get/languages/macrofamily_names", to: "languages#all_macrofamily_names"
      get "/get/languages/alphabet_names", to: "languages#all_alphabet_names"
      get "/get/languages/area_names", to: "languages#all_area_names"

      get "/get/words/word_names", to: "words#all_word_names"

      # counters
      get "/get/languages/languages_count", to: "languages#languages_count"
      get "/get/translations/translations_count", to: "translations#translations_count"
      get "/get/words/words_count", to: "words#words_count"
    end
  end
end
