ActiveRecord::Schema.define(version: 2020_02_24_063146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.string "alphabet"
    t.string "macrofamily"
    t.string "family"
    t.string "subfamily"
    t.string "area"
    t.string "area2"
    t.string "area3"
    t.string "notes"
    t.string "alive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: :cascade do |t|
    t.bigint "language_id", null: false
    t.bigint "word_id", null: false
    t.string "translation"
    t.string "romanization"
    t.string "link"
    t.string "gender"
    t.string "etymology"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["language_id"], name: "index_translations_on_language_id"
    t.index ["word_id"], name: "index_translations_on_word_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "translations", "languages"
  add_foreign_key "translations", "words"
end
