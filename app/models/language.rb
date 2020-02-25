class Language < ApplicationRecord
  has_many :translations, dependent: :destroy
  has_many :words, through: :translations
end
