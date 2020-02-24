class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :abbreviation
      t.string :alphabet
      t.string :macrofamily
      t.string :family
      t.string :subfamily
      t.string :area
      t.string :area2
      t.string :area3
      t.string :notes
      t.string :alive
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
