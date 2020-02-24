class Word < ApplicationRecord
  has_many :translations
  has_many :languages, through: :translations
end
