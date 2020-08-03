class TranslationSeedSerializer < ActiveModel::Serializer
  attributes :etymology, :gender, :link, :romanization, :translation, :language, :word_name

  def word_name
    object.word.word_name
  end

  def language
    object.language.name
  end

end
