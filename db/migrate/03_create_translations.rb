class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.integer :language_id, null: false, foreign_key: true
      t.integer :word_id, null: false, foreign_key: true
      t.text :etymology
      t.string :gender
      t.string :link
      t.string :romanization
      t.string :translation
      t.timestamps
    end
  end
end
