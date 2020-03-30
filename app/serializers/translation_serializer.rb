class TranslationSerializer < ActiveModel::Serializer
  attributes :id, :translation, :romanization, :link, :gender, :etymology
  belongs_to :language
  belongs_to :word
end
