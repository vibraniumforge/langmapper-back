class TranslationSerializer < ActiveModel::Serializer
  attributes :id, :etymology, :gender, :link, :romanization, :translation
  belongs_to :language
  belongs_to :word
end
