Language.destroy_all
Word.destroy_all
Translation.destroy_all


Language.create({name: "English", abbreviation: "en", alphabet: "Latn", family: "Indo-European", subfamily: "West Germanic", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "Spanish", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", family: "Indo-European", subfamily: "Romance", area: "Europe"})

Word.create({name: "gold"})




  create_table "translations", force: :cascade do |t|
    t.bigint "language_id", null: false
    t.bigint "word_id", null: false
    t.string "translation"
    t.string "romanization"
    t.string "link"
    t.string "etymology"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_translations_on_language_id"
    t.index ["word_id"], name: "index_translations_on_word_id"
  end

