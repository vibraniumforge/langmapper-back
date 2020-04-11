class Language < ApplicationRecord
  has_many :translations, dependent: :destroy
  has_many :words, through: :translations

  validates :name, presence: true
  validates :abbreviation, length: { in: 2..3 }, allow_blank: true
  validates :alive, inclusion: { in: [true, false] }, allow_blank: true

  def self.current_langauges_hash
    all_langs = Language.all.pluck(:id, :name)
    all_langs.map do |lang|
      Hash[id: lang[0], name: lang[1]]
    end
  end

end
