class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :alphabet, :macrofamily, :family, :subfamily, :area, :area2, :notes, :alive
end
