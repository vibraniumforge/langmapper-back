class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.integer :language_id, null: false, foreign_key: true
      t.integer :word_id, null: false, foreign_key: true
      t.string :language_name
      t.string :translation
      t.string :romanization
      t.string :link
      t.string :gender
      t.string :etymology
      t.timestamps
    end
  end
end
