class Word < ApplicationRecord
  has_many :translations, dependent: :destroy
  has_many :languages, through: :translations

  validates :name, presence: true
end
