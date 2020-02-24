class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :alphabet, :family, :subfamily
end
