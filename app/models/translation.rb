# encoding: utf-8
class Translation < ApplicationRecord
  include DataConcern::ClassMethods
  include MapConcern::ClassMethods

  belongs_to :language
  belongs_to :word

  validates :translation, presence: true
  validates :link, presence: true

  # Find all translations of a WORD in ALL LANGUAGES
  def self.find_all_translations_by_word(query)
    word_id = Word.find_by("word_name = ?", query.downcase).id
    Translation.joins(:language).select("translations.*, languages.name").where(word_id: word_id).order(:name)
  end

  # all translations of a WORD in a MACROFAMILY. Gender is inside
  def self.find_all_translations_by_gender(word_name, macrofamily = "Indo-European")
    word_id = Word.find_by(word_name: word_name.downcase).id
    Translation.joins(:language).select("translations.*, languages.*, languages.id as language_id, translations.id as id").where("word_id = ? AND macrofamily = ?", word_id, macrofamily).order(:family)
  end

  # Translations that contain the query word inside the Translation etymology.
  def self.find_etymology_containing(query)
    Translation.joins(:language, :word).select("translations.*, languages.name, words.word_name ").where("etymology LIKE :query", query: "%#{sanitize_sql_like(query)}%")
  end

    # all the translations of EVERY WORD in a MACROFAMILY
    def self.find_all_translations_by_macrofamily(macrofamily)
      Translation.joins(:language).select("translations.*, languages.*").where("macrofamily = ?", macrofamily).order(:family)
    end
  
    # all the TRANSLATIONS from a specified LANGUAGE
    def self.find_all_translations_by_language(language)
      language_id = Language.find_by(name: language).id
      Translation.joins(:word).select("translations.*, words.word_name").where("language_id = ?", language_id).order(:romanization)
    end
  
    # find all the translations of the word_name && are in area1 || area2 || area3.
    def self.find_all_translations_by_area(area, word_name)
      word_id = Word.find_by(word_name: word_name.downcase).id
      Translation.joins(:language, :word).select("translations.*, languages.*, languages.id as language_id, words.word_name").where("area1 = ?", area).or(Translation.joins(:language, :word).select("translations.*, languages.*, languages.id as language_id, words.word_name").where("area2 = ?", area)).or(Translation.joins(:language, :word).select("translations.*, languages.*, languages.id as language_id, words.word_name").where("area3 = ?", area)).where("word_id = ?", word_id).order(:macrofamily, :family)
    end

  # make a hash group by etymology
  def self.find_grouped_etymologies(query, macrofamily = "Indo-European")
    word_id = Word.find_by("word_name = ?", query.downcase).id
    protos_array = ["Proto-Indo-European", "Proto-Anatolian", "Proto-Tocharian", "Proto-Italic", "Vulgar Latin", "Latin", "Proto-Celtic", "Proto-Brythonic", "Proto-Germanic", "Proto-Balto-Slavic", "Proto-Baltic", "Proto-Slavic", "Proto-Indo-Iranian", "Proto-Indic", "Proto-Iranian", "Proto-Armenian", "Old Armenian", "Proto-Greek", "Ancient Greek", "Proto-Albanian", "Old Dutch", "Old English", "Old Norse", "Old High German", "Old Frisian", "Old French", "Proto-Basque", "Proto-Kartvelian", "Old Georgian", "Old Turkic", "Proto-Turkic", "Proto-Uralic", "Proto-Finnic", "Proto-Samic"]
    array = []
    ety_hash = Hash.new { |k, v| }
    translations_array = Language.select([:id, :family, :name, :romanization, :etymology])
      .joins(:translations)
      .where("word_id = ? AND macrofamily = ?", word_id, macrofamily)
      .order(:etymology)
    # can I make a hash of these server side?
    # why doesnt etymology appear when look at translations_array?
    translations_array.each do |translation|
      if translation.etymology.nil?
        short_etymology = "Null"
      else
        short_etymology = translation.etymology.strip
        # short_etymology = translation.etymology.slice(0,60).strip
      end
      if ety_hash[short_etymology]
        ety_hash[short_etymology] << translation.name
      else
        ety_hash[short_etymology] = [translation.name]
      end
    end
    ety_hash.each do |h|
      array << h
    end
    pp ety_hash
    array
  end

end
