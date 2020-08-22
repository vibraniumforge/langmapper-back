class Language < ApplicationRecord
  has_many :translations, dependent: :destroy
  has_many :words, through: :translations

  validates :name, presence: true
  validates :abbreviation, length: { in: 2..3 }, allow_blank: false
  # validates :alive, inclusion: { in: [true, false] }, allow_blank: true

  def self.current_langauges_hash
    Language.select(:id, :name).order(:id)
  end

  # helpers

  def self.all_macrofamily_names
    Language.select(:macrofamily).distinct.order(:macrofamily).pluck(:macrofamily)
  end

  def self.all_alphabet_names
    Language.select(:alphabet).distinct.order(:alphabet).pluck(:alphabet)
  end

  def self.all_area_names
    # Language.select(:area1, :area2, :area3).distinct.pluck(:area1, :area2, :area3).flatten.uniq.reject{|x|x.blank?}.sort
    # Language.distinct(:area1).pluck(:area1).union(Language.distinct(:area2).pluck(:area2)).union(Language.distinct(:area3).pluck(:area3))
    # Language.distinct(:area1).where.not(area1: "").pluck(:area1).union(Language.distinct(:area2).where.not(area2: "").pluck(:area2)).union(Language.distinct(:area3).where.not(area3: "").pluck(:area3))
    # Language.distinct("area1 as areas").where.not(area1: "").pluck(:area1).union(Language.distinct(:area2).where.not(area2: "").pluck(:area2)).union(Language.distinct(:area3).where.not(area3: "").pluck(:area3)).sort
    Language.distinct.where.not(area1: "").pluck(:area1).union(Language.distinct(:area2).where.not(area2: "").pluck(:area2)).union(Language.distinct(:area3).where.not(area3: "").pluck(:area3)).sort
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


# SELECT DISTINCT area1 
# AS areas
# 	FROM languages
# 	WHERE NOT area1 = ''
# 	UNION
# 	SELECT DISTINCT area2 
# 	FROM languages
# 	WHERE NOT area2 = ''
# 	UNION
# 	SELECT DISTINCT area3 
# 	FROM languages
# 	WHERE NOT area3 = ''
# ORDER BY languages.areas asc