class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :abbreviation
      t.string :alphabet
      t.string :family
      t.string :subfamily

      t.timestamps
    end
  end
end
