class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :abbreviation, :alphabet, :macrofamily, :family, :subfamily, :area, :area2, :area3, :notes, :alive
end
