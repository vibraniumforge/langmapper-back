Language.destroy_all
Word.destroy_all
Translation.destroy_all

# Language.create({name: "", abbreviation: "", alphabet: "", macrofamily: "", family: "", subfamily: "", area: "", area2: "", notes: "", alive: nil })

# Indo-European

# Germanic
Language.create({name: "English", abbreviation: "en", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe", area2: "British Isles", area3: "", notes: "", alive: true })
Language.create({name: "Scots", abbreviation: "sco", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe", area2: "British Isles", area3: "", notes: "Lowland Scots (Germanic)", alive: true })

Language.create({name: "Dutch", abbreviation: "nl", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic",  area: "Europe", area2: "Central Europe", notes: "", alive: true })
Language.create({name: "West Frisian", abbreviation: "fy", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe", area2: "Central Europe", notes: "Netherlands", alive: true })
Language.create({name: "North Frisian", abbreviation: "frr", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic",  area: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })
Language.create({name: "Saterland Frisian", abbreviation: "stq", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })

Language.create({name: "Low Saxon", abbreviation: "nds", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe",  area2: "Central Europe", area3: "Germany", notes: "", alive: true })

Language.create({name: "German", abbreviation: "de", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })
Language.create({name: "Bavarian", abbreviation: "bar", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })
Language.create({name: "Alemanic", abbreviation: "gsw", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })


Language.create({name: "Swedish", abbreviation: "sv", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })
Language.create({name: "Danish", abbreviation: "da", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })
Language.create({name: "Norwegian", abbreviation: "no", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })
Language.create({name: "Icelandic", abbreviation: "is", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })
Language.create({name: "Faroese", abbreviation: "fo", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })

# Italic
Language.create({name: "French", abbreviation: "fr", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })
Language.create({name: "Spanish", abbreviation: "es", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({name: "Portuguese", abbreviation: "pt", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Iberia", notes: "", alive: true })
Language.create({name: "Italian", abbreviation: "it", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Eastern Romance", area: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({name: "Romanian", abbreviation: "ro", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Eastern Romance", area: "Europe", area2: "East Europe", notes: "", alive: true })
Language.create({name: "Catalan", abbreviation: "ca", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({name: "Occitan", abbreviation: "oc", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })
Language.create({name: "Romansh", abbreviation: "rm", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "France", notes: "Switzerland", alive: true })
Language.create({name: "Sardinian", abbreviation: "sc", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Eastern Romance", area: "Europe", area2: "Italy", notes: "", alive: true })
Language.create({name: "Franco-Provençal", abbreviation: "frp", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })
Language.create({name: "Friulian", abbreviation: "fur", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })
Language.create({name: "Ladin", abbreviation: "lld", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: true })
Language.create({name: "Venetian", abbreviation: "vnc", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })
Language.create({name: "Galician", abbreviation: "gl", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Western Romance", area: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })

# Celtic
Language.create({name: "Irish", abbreviation: "ga", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Goidelic", area: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({name: "Scottish Gaelic", abbreviation: "gd", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Goidelic", area: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({name: "Welsh", abbreviation: "cy", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Brittonic", area: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({name: "Manx", abbreviation: "gv", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Goidelic", area: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({name: "Cornish", abbreviation: "kw", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Brittonic", area: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({name: "Breton", abbreviation: "br", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Brittonic", area: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })

# Slavic
Language.create({name: "Russian", abbreviation: "ru", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Slavic", subfamily: "East Slavic", area: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({name: "Ukranian", abbreviation: "uk", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Slavic", subfamily: "East Slavic", area: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({name: "Belarusian", abbreviation: "be", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Slavic", subfamily: "East Slavic", area: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })

Language.create({name: "Polish", abbreviation: "pl", alphabet: "Latn", macrofamily: "Indo-European", family: "Slavic", subfamily: "West Slavic", area: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({name: "Czech", abbreviation: "cs", alphabet: "Latn", macrofamily: "Indo-European", family: "Slavic", subfamily: "West Slavic", area: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({name: "Slovak", abbreviation: "sk", alphabet: "Latn", macrofamily: "Indo-European", family: "Slavic", subfamily: "West Slavic", area: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })

Language.create({name: "Bulgarian", abbreviation: "bg", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Slavic", subfamily: "South Slavic", area: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })
Language.create({name: "Serbo-Croat", abbreviation: "sh", alphabet: "Latn", macrofamily: "Indo-European", family: "Slavic", subfamily: "South Slavic", area: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })
Language.create({name: "Slovene", abbreviation: "sl", alphabet: "Latn", macrofamily: "Indo-European", family: "Slavic", subfamily: "South Slavic", area: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })

# Baltic
Language.create({name: "Lithuanian", abbreviation: "lt", alphabet: "Latn", macrofamily: "Indo-European", family: "Baltic", subfamily: "Eastern Baltic", area: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })
Language.create({name: "Latvian", abbreviation: "lv", alphabet: "Latn", macrofamily: "Indo-European", family: "Baltic", subfamily: "Eastern Baltic", area: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })

Language.create({name: "Greek", abbreviation: "el", alphabet: "Grek", macrofamily: "Indo-European", family: "Hellenic", area: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })

Language.create({name: "Albanian", abbreviation: "sq", alphabet: "Latn", macrofamily: "Indo-European", family: "Albanian", area: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })

Language.create({name: "Armenian", abbreviation: "hy", alphabet: "Armn", macrofamily: "Indo-European", family: "Armenian", area: "Middle East", area2: "Caucasus", area3: "", notes: "", alive: true })

# Indo-Iranian
Language.create({name: "Hindi", abbreviation: "hi", alphabet: "Deva", macrofamily: "Indo-European", family: "Indo-Iranian",  subfamily: "Indo-Aryan", area: "South Asia", area3: "", notes: "", alive: true })



# Uralic
Language.create({name: "Finnish", abbreviation: "fi", alphabet: "Latn", macrofamily: "Uralic", family: "Finnic", area: "Europe", area2: "Uralia", area3: "North Europe", notes: "", alive: true })
Language.create({name: "Estonian", abbreviation: "es", alphabet: "Latn", macrofamily: "Uralic", family: "Finnic", area: "Europe", area2: "Uralia", area3: "North Europe", notes: "", alive: true })
Language.create({name: "Hungarian", abbreviation: "hu", alphabet: "Latn", macrofamily: "Uralic", family: "Ugric", area: "Europe", area2: "Uralia ", area3: "", notes: "Central Europe", alive: true })

# Dravidian
Language.create({name: "Telugu", abbreviation: "te", alphabet: "Telu", macrofamily: "Dravidian", subfamily: "", area: "South Asia", area2: "", area3: "", notes: "", alive: true })

# Vasconic
Language.create({name: "Basque", abbreviation: "eu", alphabet: "Latn", macrofamily: "Isolate", family: "Vasconic", area: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })

# Austro-Asiatic
Language.create({name: "Khmer", abbreviation: "km", alphabet: "Khmr", macrofamily: "Austro-Asiatic", family: "Khmer", area: "Southeast Asia", area2: "", area3: "", notes: "a.k.a Cambodian", alive: true })
Language.create({name: "Vietnamese", abbreviation: "vi", alphabet: "Latn", macrofamily: "Austro-Asiatic", family: "Viet", area: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Austronesian
Language.create({name: "Indonesian", abbreviation: "id", alphabet: "Latn", macrofamily: "Austronesian", family: "", area: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({name: "Tagalog", abbreviation: "tl", alphabet: "Latn", macrofamily: "Austronesian", family: "", area: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Sino-Tibetan
Language.create({name: "Mandarin Chinese", abbreviation: "cmn", alphabet: "Hani", macrofamily: "Sino-Tibetan", family: "", area: "East Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({name: "Tibetan", abbreviation: "bo", alphabet: "Tibt", macrofamily: "Sino-Tibetan", family: "", area: "South Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({name: "Burmese", abbreviation: "my", alphabet: "Mymr", macrofamily: "Sino-Tibetan", family: "", area: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Tai-Kadai
Language.create({name: "Thai", abbreviation: "th", alphabet: "Thai", macrofamily: "Tai-Kadai", family: "", area: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Turkish
Language.create({name: "Turkish", abbreviation: "tk", alphabet: "Latn", macrofamily: "Turkish", family: "", area: "Anatolia", area2: "Altaic", area3: "", notes: "", alive: true })

# Mongolian
Language.create({name: "Mongolian", abbreviation: "mn", alphabet: "Mong", macrofamily: "Mongolic", family: "", area: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Tungusic
Language.create({name: "Xibe", abbreviation: "sjo", alphabet: "Mong", macrofamily: "Tungusic", family: "", area: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Japonic
Language.create({name: "Japanese", abbreviation: "ja", alphabet: "Jpan", macrofamily: "Japonic", family: "", area: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Koreanic
Language.create({name: "Korean", abbreviation: "ko", alphabet: "Kore", macrofamily: "Koreanic", family: "", area: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Ainu
Language.create({name: "Ainu", abbreviation: "ain", alphabet: "Latn", macrofamily: "Isolate", family: "Ainu", area: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Kartvelian
Language.create({name: "Georgian", abbreviation: "ka", alphabet: "Geor", macrofamily: "Kartvelian", family: "", area: "Anatolia", area2: "Caucasus", area3: "", notes: "", alive: true })

# Northeast Caucasian
Language.create({name: "Avar", abbreviation: "av", alphabet: "Cyrl", macrofamily: "Northeast Caucasian", family: "", area: "Caucasus", area2: "", area3: "", notes: "", alive: true })

# Northwest Caucasian
Language.create({name: "Ubykh", abbreviation: "uby", alphabet: "Latn", macrofamily: "Northwest Caucasian", family: "", area: "Caucasus", area2: "", area3: "", notes: "", alive: true })

# Semitic
Language.create({name: "Arabic", abbreviation: "ar", alphabet: "Arab", macrofamily: "Semitic", family: "Arabic", area: "Middle East", area2: "", area3: "", notes: "", alive: true })

# Niger-Congo
Language.create({name: "Swahili", abbreviation: "sw", alphabet: "Latn", macrofamily: "Niger-Congo", family: "Arabic", area: "Africa", area2: "", area3: "", notes: "", alive: true })

# Burushkaski
Language.create({name: "Burushkaski", abbreviation: "bsk", alphabet: "Latn", macrofamily: "Isolate", family: "Burushkaski", area: "South Asia", area2: "", area3: "", notes: "", alive: true })

# Kusunda
Language.create({name: "Kusunda", abbreviation: "kgg", alphabet: "Latn", macrofamily: "Isolate", family: "Kusunda", area: "South Asia", area2: "", area3: "", notes: "", alive: true })

# Chukotko-Kamchatkan 
Language.create({name: "Chukchi", abbreviation: "ckt", alphabet: "Cyrl", macrofamily: "Isolate", family: "Chukotko-Kamchatkan ", area: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Nivkh
Language.create({name: "Nivkh", abbreviation: "niv", alphabet: "Cyrl", macrofamily: "Isolate", family: "Nivkh", area: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Yukaghir
Language.create({name: "Omak", abbreviation: "omk", alphabet: "Cyrl", macrofamily: "Isolate", family: "Yukaghir", area: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Yeniseian
Language.create({name: "Ket", abbreviation: "ket", alphabet: "Cyrl", macrofamily: "Isolate", family: "Yeniseian", area: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Extinct, but famous
Language.create({name: "Latin", abbreviation: "la", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", area: "Europe", area2: "Italy", area3: "", notes: "", alive: false })

Language.create({name: "Ancient Greek", abbreviation: "la", alphabet: "Latn", macrofamily: "Indo-European", family: "Hellenic", area: "Europe", area2: "South Europe", area2: "", notes: "", alive: false })

Language.create({name: "Sanskrit", abbreviation: "at", alphabet: "Latn", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Indo-Aryan", area: "South Asia", area2: "", notes: "", alive: false })

Language.create({name: "Tocharian A", abbreviation: "xto", alphabet: "Latn", macrofamily: "Indo-European", family: "Tocharian", area: "Central Asia", area2: "", area3: "", notes: "", alive: false })
Language.create({name: "Tocharian B", abbreviation: "txb", alphabet: "Latn", macrofamily: "Indo-European", family: "Tocharian", area: "Central Asia", area2: "", area3: "", notes: "", alive: false })

Language.create({name: "Hittite", abbreviation: "hit", alphabet: "Latn", macrofamily: "Indo-European", family: "Anatolian", area: "Anatolia", area2: "Caucasus", area2: "", notes: "", alive: false })

Language.create({name: "Sumerian", abbreviation: "sux", alphabet: "Latn", macrofamily: "Isolate", family: "Sumerian", area: "Middle East", area2: "", area3: "", notes: "", alive: false })

Language.create({name: "Elamite", abbreviation: "elx", alphabet: "Xsux", macrofamily: "Isolate", family: "Elamite", area: "Middle East", area2: "", area3: "", notes: "", alive: false })

Language.create({name: "Ancient Egyptian", abbreviation: "egy", alphabet: "Egyp", macrofamily: "Semitic", family: "Egyptian", area: "Middle East", area2: "", area3: "", notes: "", alive: false })

Language.create({name: "Estruscan", abbreviation: "ett", alphabet: "Ital", macrofamily: "Isolate", family: "Etruscan", area: "Italy", area2: "", area3: "", notes: "", alive: false })

Language.create({name: "Iberian", abbreviation: "xib", alphabet: "Ital", macrofamily: "Isolate", family: "Iberian", area: "Iberia", area2: "", area3: "", notes: "", alive: false })

Language.create({name: "Tartessian", abbreviation: "txr", alphabet: "Grek", macrofamily: "Isolate", family: "Tartessian", area: "Iberia", area2: "", area3: "", notes: "", alive: false })


Word.create({ name: "gold" })

# Translation.create({language_id: Language.find_by(abbreviation: "").id, word_id: Word.find_by(name: "").id, translation: "", romanization: "", link: "", etymology: "From latin aurum", gender: "" })

Translation.create({language_id: Language.find_by(abbreviation: "fr").id, word_id: Word.find_by(name: "gold").id, translation:"or", romanization:"", link:"", etymology: "From latin aurum", gender: "m" })


 

puts "seeds done."