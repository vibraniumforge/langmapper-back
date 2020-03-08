class Language < ApplicationRecord
  has_many :translations, dependent: :destroy
  has_many :words, through: :translations

  validates :name, presence: true
  validates :abbreviation, length: { in: 2..3 }
  validates :alive, inclusion: { in: %w(t f) }

  # t.string "name"
  # t.string "abbreviation"
  # t.string "alphabet"
  # t.string "macrofamily"
  # t.string "family"
  # t.string "subfamily"
  # t.string "area"
  # t.string "area2"
  # t.string "area3"
  # t.string "notes"
  # t.boolean "alive"


end
