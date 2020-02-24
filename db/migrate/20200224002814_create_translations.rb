class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.references :language, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.string :translation
      t.string :romanization
      t.string :link
      t.string :etymology

      t.timestamps
    end
  end
end
