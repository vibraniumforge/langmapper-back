class TranslationSerializer < ActiveModel::Serializer
  attributes :id, :translation, :romanization, :link, :etymology
  has_one :language
  has_one :word
end
