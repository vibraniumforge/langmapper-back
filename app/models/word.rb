class Word < ApplicationRecord

  has_many :translations, dependent: :destroy
  has_many :languages, through: :translations

  validates :word_name, presence: true, uniqueness: true

  Good_words = ["Silver", "Gold", "Copper", "Iron", "Tin", "Salt", "Horse", "Cow", "Sheep", "Pig", "Dog", "Swan", "Goose", "Owl", "Falcon", "Crow", "Dove", "Eagle", "Gull", "Robin", "Wolf", "Fox", "Bear", "Mouse", "Honey", "Apple", "Milk", "Egg", "Tree", "Snow", "Rain", "Cloud", "Ice", "Frost", "Blood", "Tongue", "Tooth", "Ear", "Eye", "Nose", "Hand", "Wheel", "Day", "Dawn", "Night", "Winter", "Summer", "Autumn", "Sun", "Moon", "Sky", "Star", "Water", "Sea"]

  Good_word = ["Flower"]

  def self.all_word_names
    # Word.select("words.word_name, words.id").order("word_name ASC")
    Word.select("words.word_name, words.id").order(word_name: :asc)
  end

  def self.words_count
    Word.count
  end

  def self.find_word_definition(word)
    Word.where(word_name: word).pluck(:definition)
  end

end
