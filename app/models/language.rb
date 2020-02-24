class Language < ApplicationRecord
  has_many :translations
  has_many :words, through: :translations
end
