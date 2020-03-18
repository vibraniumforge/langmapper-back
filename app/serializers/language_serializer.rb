class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :alphabet, :macrofamily, :family, :subfamily, :area1, :area2, :area3, :notes, :alive
end
