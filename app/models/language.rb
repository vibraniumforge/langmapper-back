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

  # helpers

  def self.find_all_macrofamily_names
    Language.select(:macrofamily).distinct.order(:macrofamily).pluck(:macrofamily)
  end

  def self.find_all_alphabet_names
    Language.select(:alphabet).distinct.order(:alphabet).pluck(:alphabet)
  end

  def self.find_all_area_names
    Language.select(:area1, :area2, :area3).distinct.pluck(:area1, :area2, :area3).flatten.uniq.reject{|x|x.blank?}.sort
  end

  # searchers
  def self.find_all_languages_by_area(area)
    Language.where("area1 = ?", area).or(Language.where("area2 = ?", area)).or(Language.where("area3 = ?", area))
  end

  # counter
  def self.languages_count
    Language.count
  end

end
