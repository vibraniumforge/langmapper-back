Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :languages
      resources :words, only: [:index, :show, :new, :create, :destroy]
      # no ability to update a word. This leads to bad data.
      resources :translations, only: [:index, :show, :new, :create, :edit, :update, :destroy]

      get "/search/translation/:word", to: "translations#find_all_translations"
      get "/search/gender/:word", to: "translations#find_all_genders"
      get "/search/etymology/:word", to: "translations#find_etymology_containing"
      get "/search/grouped_etymology/:word/:macrofamily", to: "translations#find_grouped_etymologies"

      get "/search/all_translations_by_macrofamily/:macrofamily", to: "translations#find_all_translations_by_macrofamily"
      get "/search/all_translations_by_language/:language", to: "translations#find_all_translations_by_language"
      get "/search/all_languages_by_area/:location", to: "languages#find_all_languages_by_area"
      get "/search/all_translations_by_area/:location/:word", to: "translations#find_all_translations_by_area"
      get "/search/all_translations_by_area_img/:location/:word", to: "translations#find_all_translations_by_area_img"

      # helpers
      get "/search/all_macrofamily_names", to: "languages#find_all_macrofamily_names"
      get "/search/all_word_names", to: "words#find_all_words"
      get "/search/all_alphabet_names", to: "languages#find_all_alphabets"
      get "/search/all_areas", to: "languages#find_all_areas"

      # counters
      get "/search/language_count", to: "languages#language_count"
      get "/search/word_count", to: "words#word_count"
      get "/search/translation_count", to: "translations#translation_count"
    end
  end
end
