# encoding: utf-8
Language.destroy_all
Word.destroy_all
Translation.destroy_all

# Language.create({name: "", abbreviation: "", alphabet: "", macrofamily: "", family: "", subfamily: "", area1: "", area2: "", area3: "", notes: "", alive: true })

# Indo-European

# Germanic
Language.create({ name: "English", abbreviation: "en", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({ name: "Scots", abbreviation: "sco", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Western Europe", area3: "British Isles", notes: "a.k.a. Lowland Scots", alive: true })

Language.create({ name: "Dutch", abbreviation: "nl", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Afrikaans", abbreviation: "af", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Western Europe", area3: "", notes: "", alive: true })
Language.create({ name: "West Frisian", abbreviation: "fy", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "", notes: "Friesland, NL", alive: true })
Language.create({ name: "North Frisian", abbreviation: "frr", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "Nordfriesland, DE", alive: true })
Language.create({ name: "Saterland Frisian", abbreviation: "stq", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "Saxony, DE", alive: true })

Language.create({ name: "Low Saxon", abbreviation: "nds", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })

Language.create({ name: "German", abbreviation: "de", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })
Language.create({ name: "Bavarian", abbreviation: "bar", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })
Language.create({ name: "Alemannic German", abbreviation: "gsw", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })
Language.create({ name: "Luxembourgish", abbreviation: "lb", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "West Germanic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })

Language.create({ name: "Swedish", abbreviation: "sv", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area1: "Europe", area2: "North Europe", area3: "Scandanavia", notes: "", alive: true })
Language.create({ name: "Danish", abbreviation: "da", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area1: "Europe", area2: "North Europe", area3: "Scandanavia", notes: "", alive: true })
Language.create({ name: "Norwegian", abbreviation: "no", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area1: "Europe", area2: "North Europe", area3: "Scandanavia", notes: "", alive: true })
Language.create({ name: "Icelandic", abbreviation: "is", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area1: "Europe", area2: "North Europe", area3: "Scandanavia", notes: "", alive: true })
Language.create({ name: "Faroese", abbreviation: "fo", alphabet: "Latn", macrofamily: "Indo-European", family: "Germanic", subfamily: "North Germanic", area1: "Europe", area2: "North Europe", area3: "Scandanavia", notes: "", alive: true })

# Italic
Language.create({ name: "Portuguese", abbreviation: "pt", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Ibero-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({ name: "Galician", abbreviation: "gl", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Ibero-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({ name: "Mirandese", abbreviation: "mwl", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Ibero-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({ name: "Asturian", abbreviation: "ast", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Ibero-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
# Language.create({ name: "Leonese", abbreviation: "", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Ibero-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({ name: "Spanish", abbreviation: "es", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Ibero-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({ name: "Aragonese", abbreviation: "an", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Ibero-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })

Language.create({ name: "Catalan", abbreviation: "ca", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Occitano-Romance", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({ name: "Occitan", abbreviation: "oc", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Occitano-Romance", area1: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })

Language.create({ name: "French", abbreviation: "fr", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Gallo- Romance", area1: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })
Language.create({ name: "Franco-Provençal", abbreviation: "frp", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Gallo-Romance", area1: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })

Language.create({ name: "Romansch", abbreviation: "rm", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Rhaeto-Romance", area1: "Europe", area2: "Central Europe", area3: "Switzerland", notes: "Switzerland", alive: true })
Language.create({ name: "Ladin", abbreviation: "lld", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Rhaeto-Romance", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Friulian", abbreviation: "fur", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Rhaeto-Romance", area1: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })

Language.create({ name: "Piedmontese", abbreviation: "pms", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Gallo-Italic", area1: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Ligurian", abbreviation: "lij", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Gallo-Italic", area1: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Lombard", abbreviation: "lmo", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Gallo-Italic", area1: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Emilian", abbreviation: "egl", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Gallo-Italic", area1: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Venetian", abbreviation: "vnc", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Gallo-Italic", area1: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })

Language.create({ name: "Italian", abbreviation: "it", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: false })
# Language.create({ name: "Tuscan", abbreviation: "", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })
Language.create({ name: "Corsican", abbreviation: "co", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Sassarese", abbreviation: "sdc", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Sicilian", abbreviation: "scn", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Neapolitan", abbreviation: "nap", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: true })
Language.create({ name: "Dalmatian", abbreviation: "dlm", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: false })
Language.create({ name: "Istriot", abbreviation: "ist", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Italo-Dalmatian", area1: "Europe", area2: "Central Europe", area3: "Italy", notes: "", alive: true })

Language.create({ name: "Sardinian", abbreviation: "sc", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Sardinian", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: true })

Language.create({ name: "Romanian", abbreviation: "ro", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Eastern Romance", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Istro-Romanian", abbreviation: "ruo", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Eastern Romance", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Aromanian", abbreviation: "rup", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Eastern Romance", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Megleno-Romanian", abbreviation: "ruq", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "Eastern Romance", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })

# Celtic
Language.create({ name: "Irish", abbreviation: "ga", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Goidelic", area1: "Europe", area2: "Western Europe", area3: "British Isles", notes: "a.k.a. Gaelic", alive: true })
Language.create({ name: "Scottish Gaelic", abbreviation: "gd", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Goidelic", area1: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({ name: "Manx", abbreviation: "gv", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Goidelic", area1: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({ name: "Welsh", abbreviation: "cy", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Brittonic", area1: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({ name: "Cornish", abbreviation: "kw", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Brittonic", area1: "Europe", area2: "Western Europe", area3: "British Isles", notes: "", alive: true })
Language.create({ name: "Breton", abbreviation: "br", alphabet: "Latn", macrofamily: "Indo-European", family: "Celtic", subfamily: "Brittonic", area1: "Europe", area2: "Western Europe", area3: "France", notes: "", alive: true })

# Balto-Slavic
Language.create({ name: "Russian", abbreviation: "ru", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "East Slavic", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Ukrainian", abbreviation: "uk", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "East Slavic", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Belarusian", abbreviation: "be", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "East Slavic", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Rusyn", abbreviation: "rue", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "East Slavic", area1: "Europe", area2: "East Europe", area3: "", notes: "", alive: true })

Language.create({ name: "Czech", abbreviation: "cs", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "West Slavic", area1: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Slovak", abbreviation: "sk", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "West Slavic", area1: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Polish", abbreviation: "pl", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "West Slavic", area1: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Silesian", abbreviation: "szl", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "West Slavic", area1: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Kashubian", abbreviation: "csb", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "West Slavic", area1: "Europe", area2: "Central Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Upper Sorbian", abbreviation: "hsb", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "West Slavic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })
Language.create({ name: "Lower Sorbian", abbreviation: "dsb", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "West Slavic", area1: "Europe", area2: "Central Europe", area3: "Germany", notes: "", alive: true })

Language.create({ name: "Bulgarian", abbreviation: "bg", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "South Slavic", area1: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Serbo-Croatian", abbreviation: "sh", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "South Slavic", area1: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Macedonian", abbreviation: "mk", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "South Slavic", area1: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Slovene", abbreviation: "sl", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "South Slavic", area1: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })

# Baltic
Language.create({ name: "Latvian", abbreviation: "lv", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "East Baltic", area1: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })
Language.create({ name: "Lithuanian", abbreviation: "lt", alphabet: "Latn", macrofamily: "Indo-European", family: "Balto‑Slavic", subfamily: "East Baltic", area1: "Europe", area2: "North Europe", area3: "", notes: "", alive: true })

# Singles in Indo-European
Language.create({ name: "Greek", abbreviation: "el", alphabet: "Grek", macrofamily: "Indo-European", family: "Hellenic", subfamily: "", area1: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })

Language.create({ name: "Albanian", abbreviation: "sq", alphabet: "Latn", macrofamily: "Indo-European", family: "Albanian", subfamily: "", area1: "Europe", area2: "South Europe", area3: "", notes: "", alive: true })

Language.create({ name: "Armenian", abbreviation: "hy", alphabet: "Armn", macrofamily: "Indo-European", family: "Armenian", subfamily: "", area1: "Middle East", area2: "Caucasus", area3: "Europe", notes: "", alive: true })

# Indo-Iranian
Language.create({ name: "Hindi", abbreviation: "hi", alphabet: "Deva", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Indo-Aryan", area1: "South Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Persian", abbreviation: "fa", alphabet: "fa-Arab", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Iranic", area1: "Middle East", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Kurdish", abbreviation: "ku", alphabet: "Latn", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Iranic", area1: "Middle East", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Askun", abbreviation: "ask", alphabet: "Latn", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Nuristani", area1: "South Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Ossetian", abbreviation: "os", alphabet: "Cyrl", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Scythian", area1: "Caucasus", area2: "", area3: "Europe", notes: "", alive: true })

# Vasconic
Language.create({ name: "Basque", abbreviation: "eu", alphabet: "Latn", macrofamily: "Isolate", family: "Vasconic", subfamily: "", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: true })

# Uralic
Language.create({ name: "Finnish", abbreviation: "fi", alphabet: "Latn", macrofamily: "Uralic", family: "Finnic", subfamily: "", area1: "Europe", area2: "Uralia", area3: "North Europe", notes: "", alive: true })
Language.create({ name: "Estonian", abbreviation: "et", alphabet: "Latn", macrofamily: "Uralic", family: "Finnic", subfamily: "", area1: "Europe", area2: "Uralia", area3: "North Europe", notes: "", alive: true })
Language.create({ name: "Karelian", abbreviation: "krl", alphabet: "Latn", macrofamily: "Uralic", family: "Finnic", subfamily: "", area1: "Europe", area2: "Uralia", area3: "North Europe", notes: "", alive: true })
Language.create({ name: "Hungarian", abbreviation: "hu", alphabet: "Latn", macrofamily: "Uralic", family: "Ugric", subfamily: "", area1: "Europe", area2: "Uralia", area3: "Central Europe", notes: "", alive: true })
Language.create({ name: "Northern Sami", abbreviation: "se", alphabet: "Latn", macrofamily: "Uralic", family: "Sami", subfamily: "", area1: "Europe", area2: "Uralia", area3: "Europe", notes: "", alive: true })

# Dravidian
Language.create({ name: "Telugu", abbreviation: "te", alphabet: "Telu", macrofamily: "Dravidian", family: "South Central", subfamily: "", area1: "South Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Tamil", abbreviation: "ta", alphabet: "Taml", macrofamily: "Dravidian", family: "South", subfamily: "", area1: "South Asia", area2: "", area3: "", notes: "", alive: true })

# Austro-Asiatic
Language.create({ name: "Khmer", abbreviation: "km", alphabet: "Khmr", macrofamily: "Austro-Asiatic", family: "Khmeric", subfamily: "", area1: "Southeast Asia", area2: "", area3: "", notes: "a.k.a Cambodian", alive: true })
Language.create({ name: "Vietnamese", abbreviation: "vi", alphabet: "Latn", macrofamily: "Austro-Asiatic", family: "Viet", subfamily: "", area1: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Austronesian
Language.create({ name: "Indonesian", abbreviation: "id", alphabet: "Latn", macrofamily: "Austronesian", family: "", subfamily: "", area1: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Tagalog", abbreviation: "tl", alphabet: "Latn", macrofamily: "Austronesian", family: "", subfamily: "", area1: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Sino-Tibetan
Language.create({ name: "Chinese", abbreviation: "cmn", alphabet: "Hani", macrofamily: "Sino-Tibetan", family: "", subfamily: "", area1: "East Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Tibetan", abbreviation: "bo", alphabet: "Tibt", macrofamily: "Sino-Tibetan", family: "", subfamily: "", area1: "South Asia", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Burmese", abbreviation: "my", alphabet: "Mymr", macrofamily: "Sino-Tibetan", family: "", subfamily: "", area1: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Tai-Kadai
Language.create({ name: "Thai", abbreviation: "th", alphabet: "Thai", macrofamily: "Tai-Kadai", family: "", subfamily: "", area1: "Southeast Asia", area2: "", area3: "", notes: "", alive: true })

# Turkish
Language.create({ name: "Turkish", abbreviation: "tk", alphabet: "Latn", macrofamily: "Turkic", family: "Oghuz", subfamily: "", area1: "Anatolia", area2: "Altaic", area3: "Europe", notes: "", alive: true })
Language.create({ name: "Azerbaijani", abbreviation: "az", alphabet: "Latn", macrofamily: "Turkic", family: "Oghuz", subfamily: "", area1: "Caucasus", area2: "Altaic", area3: "Europe", notes: "", alive: true })
Language.create({ name: "Turkmen", abbreviation: "tr", alphabet: "Latn", macrofamily: "Turkic", family: "Oghuz", subfamily: "", area1: "Central Asia", area2: "Altaic", area3: "", notes: "", alive: true })
Language.create({ name: "Gagauz", abbreviation: "gag", alphabet: "Latn", macrofamily: "Turkic", family: "Oghuz", subfamily: "", area1: "Central Asia", area2: "Altaic", area3: "Europe", notes: "", alive: true })
Language.create({ name: "Uzbek", abbreviation: "uz", alphabet: "Latn", macrofamily: "Turkic", family: "Karluk", subfamily: "", area1: "Central Asia", area2: "Altaic", area3: "", notes: "", alive: true })
Language.create({ name: "Kazakh", abbreviation: "kk", alphabet: "Latn", macrofamily: "Turkic", family: "Kipchak-Nogai", subfamily: "", area1: "Central Asia", area2: "Altaic", area3: "Europe", notes: "", alive: true })
Language.create({ name: "Kyrgyz", abbreviation: "ky", alphabet: "Latn", macrofamily: "Turkic", family: "Kipchak", subfamily: "", area1: "Central Asia", area2: "Altaic", area3: "", notes: "", alive: true })
Language.create({ name: "Uyghur", abbreviation: "ug", alphabet: "Latn", macrofamily: "Turkic", family: "Karluk", subfamily: "", area1: "Central Asia", area2: "Altaic", area3: "East Asia", notes: "", alive: true })
Language.create({ name: "Tatar", abbreviation: "tt", alphabet: "Cyrl", macrofamily: "Turkic", family: "Kipchak-Bulgar", subfamily: "", area1: "Central Asia", area2: "Altaic", area3: "Europe", notes: "", alive: true })

# Mongolian
Language.create({ name: "Mongolian", abbreviation: "mn", alphabet: "Mong", macrofamily: "Mongolic", family: "", subfamily: "", area1: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })
Language.create({ name: "Kalmyk", abbreviation: "xal", alphabet: "Cyrl", macrofamily: "Mongolic", family: "", subfamily: "", area1: "East Asia", area2: "Altaic", area3: "Europe", notes: "", alive: true })

# Tungusic
Language.create({ name: "Xibe", abbreviation: "sjo", alphabet: "Mong", macrofamily: "Tungusic", family: "", subfamily: "", area1: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Japonic
# Language.create({ name: "Japanese", abbreviation: "ja", alphabet: "Jpan", macrofamily: "Isolate", family: "Japonic", subfamily: "Altaic", area1: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Koreanic
Language.create({ name: "Korean", abbreviation: "ko", alphabet: "Kore", macrofamily: "Isolate", family: "Koreanic", subfamily: "", area1: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Kartvelian
Language.create({ name: "Georgian", abbreviation: "ka", alphabet: "Geor", macrofamily: "Kartvelian", family: "Zan", subfamily: "", area1: "Anatolia", area2: "Caucasus", area3: "Europe", notes: "", alive: true })
Language.create({ name: "Mingrelian", abbreviation: "xmf", alphabet: "Geor", macrofamily: "Kartvelian", family: "Zan", subfamily: "", area1: "Anatolia", area2: "Caucasus", area3: "", notes: "", alive: true })
Language.create({ name: "Laz", abbreviation: "lzz", alphabet: "Geor", macrofamily: "Kartvelian", family: "Zan", subfamily: "", area1: "Anatolia", area2: "Caucasus", area3: "", notes: "", alive: true })
Language.create({ name: "Svan", abbreviation: "sva", alphabet: "Geor", macrofamily: "Kartvelian", family: "Svan", subfamily: "", area1: "Anatolia", area2: "Caucasus", area3: "", notes: "", alive: true })

# Northeast Caucasian
Language.create({ name: "Avar", abbreviation: "av", alphabet: "Cyrl", macrofamily: "Northeast Caucasian", family: "", subfamily: "", area1: "Caucasus", area2: "", area3: "", notes: "", alive: true })

# Northwest Caucasian
Language.create({ name: "Abaza", abbreviation: "abq", alphabet: "Cyrl", macrofamily: "Northwest Caucasian", family: "Abkhaz-Abaza", subfamily: "", area1: "Caucasus", area2: "", area3: "Europe", notes: "", alive: true })
Language.create({ name: "Abhkaz", abbreviation: "ab", alphabet: "Cyrl", macrofamily: "Northwest Caucasian", family: "Abkhaz-Abaza", subfamily: "", area1: "Caucasus", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Adyge", abbreviation: "ady", alphabet: "Cyrl", macrofamily: "Northwest Caucasian", family: "Circassian", subfamily: "", area1: "Caucasus", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Kabardian", abbreviation: "kbd", alphabet: "Cyrl", macrofamily: "Northwest Caucasian", family: "Circassian", subfamily: "", area1: "Caucasus", area2: "", area3: "", notes: "", alive: true })
Language.create({ name: "Ubykh", abbreviation: "uby", alphabet: "Cyrl", macrofamily: "Northwest Caucasian", family: "", subfamily: "Ubykh", area1: "Caucasus", area2: "", area3: "", notes: "", alive: false })

# Afro-Asiatic
Language.create({ name: "Arabic", abbreviation: "ar", alphabet: "Arab", macrofamily: "Afro-Asiatic", family: "Semitic", subfamily: "Arabic", area1: "Middle East", area2: "", area3: "Europe", notes: "", alive: true })
Language.create({ name: "Maltese", abbreviation: "mt", alphabet: "Latn", macrofamily: "Afro-Asiatic", family: "Semitic", subfamily: "Arabic", area1: "Middle East", area2: "", area3: "Europe", notes: "", alive: true })

# Niger-Congo
Language.create({ name: "Swahili", abbreviation: "sw", alphabet: "Latn", macrofamily: "Niger-Congo", family: "", subfamily: "", area1: "Africa", area2: "", area3: "", notes: "", alive: true })

# Burushkaski
Language.create({ name: "Burushkaski", abbreviation: "bsk", alphabet: "Latn", macrofamily: "Isolate", family: "Burushkaski", subfamily: "", area1: "South Asia", area2: "", area3: "", notes: "", alive: true })

# Kusunda
Language.create({ name: "Kusunda", abbreviation: "kgg", alphabet: "Latn", macrofamily: "Isolate", family: "Kusunda", subfamily: "", area1: "South Asia", area2: "", area3: "", notes: "", alive: true })

# Chukotko-Kamchatkan
Language.create({ name: "Chukchi", abbreviation: "ckt", alphabet: "Cyrl", macrofamily: "Isolate", family: "Chukotko-Kamchatkan", subfamily: "", area1: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Nivkh
Language.create({ name: "Nivkh", abbreviation: "niv", alphabet: "Cyrl", macrofamily: "Isolate", family: "Nivkh", subfamily: "", area1: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Yukaghir
Language.create({ name: "Omak", abbreviation: "omk", alphabet: "Cyrl", macrofamily: "Isolate", family: "Yukaghir", subfamily: "", area1: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Yeniseian
Language.create({ name: "Ket", abbreviation: "ket", alphabet: "Cyrl", macrofamily: "Isolate", family: "Yeniseian", subfamily: "", area1: "North Asia", area2: "", area3: "", notes: "", alive: true })

# Ainu
Language.create({ name: "Ainu", abbreviation: "ain", alphabet: "Latn", macrofamily: "Isolate", family: "Ainu", subfamily: "", area1: "East Asia", area2: "Altaic", area3: "", notes: "", alive: true })

# Extinct, but famous
Language.create({ name: "Latin", abbreviation: "la", alphabet: "Latn", macrofamily: "Indo-European", family: "Italic", subfamily: "", area1: "Europe", area2: "Western Europe", area3: "Italy", notes: "", alive: false })

Language.create({ name: "Ancient Greek", abbreviation: "grc", alphabet: "Latn", macrofamily: "Indo-European", subfamily: "", family: "Hellenic", area1: "Europe", area2: "South Europe", area3: "", notes: "", alive: false })

Language.create({ name: "Sanskrit", abbreviation: "at", alphabet: "Latn", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Indo-Aryan", area1: "South Asia", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Avestan", abbreviation: "ae", alphabet: "Avst", macrofamily: "Indo-European", family: "Indo-Iranian", subfamily: "Iranian", area1: "Middle East", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Tocharian A", abbreviation: "xto", alphabet: "Latn", macrofamily: "Indo-European", family: "Tocharian", subfamily: "", area1: "Central Asia", area2: "", area3: "", notes: "", alive: false })
Language.create({ name: "Tocharian B", abbreviation: "txb", alphabet: "Latn", macrofamily: "Indo-European", family: "Tocharian", subfamily: "", area1: "Central Asia", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Hittite", abbreviation: "hit", alphabet: "Latn", macrofamily: "Indo-European", family: "Anatolian", subfamily: "", area1: "Anatolia", area2: "Caucasus", area3: "", notes: "", alive: false })

Language.create({ name: "Sumerian", abbreviation: "sux", alphabet: "Latn", macrofamily: "Isolate", family: "Sumerian", subfamily: "", area1: "Middle East", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Elamite", abbreviation: "elx", alphabet: "Xsux", macrofamily: "Isolate", family: "Elamite", subfamily: "", area1: "Middle East", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Ancient Egyptian", abbreviation: "egy", alphabet: "Egyp", macrofamily: "Afro-Asiatic", family: "Egyptian", subfamily: "", area1: "Middle East", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Etruscan", abbreviation: "ett", alphabet: "Ital", macrofamily: "Isolate", family: "Etruscan", subfamily: "", area1: "", area2: "", area3: "Italy", notes: "", alive: false })

Language.create({ name: "Iberian", abbreviation: "xib", alphabet: "Ital", macrofamily: "Isolate", family: "Iberian", subfamily: "", area1: "Iberia", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Tartessian", abbreviation: "txr", alphabet: "Grek", macrofamily: "Isolate", family: "Tartessian", subfamily: "", area1: "Iberia", area2: "", area3: "", notes: "", alive: false })

# Proto Languages
Language.create({ name: "Proto-Indo-European", abbreviation: "pie", alphabet: "Latn", macrofamily: "Indo-European", family: "", subfamily: "", area1: "", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Proto-Uralic", abbreviation: "", alphabet: "Latn", macrofamily: "Uralic", family: "", subfamily: "", area1: "", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Proto-Basque", abbreviation: "", alphabet: "Latn", macrofamily: "Isolate", family: "Basque", subfamily: "", area1: "Europe", area2: "Western Europe", area3: "Iberia", notes: "", alive: false })

Language.create({ name: "Proto-Afro-Asiatic", abbreviation: "", alphabet: "Latn", macrofamily: "Afro-Asiatic", family: "", subfamily: "", area1: "", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Proto-Dravidian", abbreviation: "", alphabet: "Latn", macrofamily: "Dravidian", family: "", subfamily: "", area1: "", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Proto-Turkic", abbreviation: "", alphabet: "Latn", macrofamily: "Turkic", family: "", subfamily: "", area1: "", area2: "", area3: "", notes: "", alive: false })

Language.create({ name: "Proto-Austro-Asiatic", abbreviation: "", alphabet: "Latn", macrofamily: "Austro-Asiatic", family: "", subfamily: "", area1: "", area2: "", area3: "", notes: "", alive: false })

# Word.create({ word_name: "Gold" })
# Word.create({ word_name: "Silver" })
# Word.create({ word_name: "Iron" })
# Word.create({ word_name: "Copper" })
# Word.create({ word_name: "Tin" })
# Word.create({ word_name: "Lead" })
# Word.create({ word_name: "Mercury" })
# Word.create({ word_name: "Salt" })

# Word.create({ word_name: "Swan" })
# Word.create({ word_name: "Goose" })
# Word.create({ word_name: "Wolf" })
# Word.create({ word_name: "Horse" })
# Word.create({ word_name: "Cow" })
# Word.create({ word_name: "Sheep" })
# Word.create({ word_name: "Mouse" })
# Word.create({ word_name: "Pig" })
# Word.create({ word_name: "Fox" })
# Word.create({ word_name: "Bear" })
# Word.create({ word_name: "Duck" })
# Word.create({ word_name: "Dog" })
# Word.create({ word_name: "Snake" })
# Word.create({ word_name: "Weasel" })

# Word.create({ word_name: "Honey" })
# Word.create({ word_name: "Apple" })
# Word.create({ word_name: "Milk" })

# Word.create({ word_name: "Tree" })

# Word.create({ word_name: "Snow" })
# Word.create({ word_name: "Rain" })
# Word.create({ word_name: "Wind" })
# Word.create({ word_name: "Ice" })
# Word.create({ word_name: "Frost" })

# Word.create({ word_name: "Tongue" })
# Word.create({ word_name: "Tooth" })
# Word.create({ word_name: "Ear" })
# Word.create({ word_name: "Eye" })
# Word.create({ word_name: "Nose" })
# Word.create({ word_name: "Hand" })
# Word.create({ word_name: "Leg" })

# Word.create({ word_name: "Wheel" })

# Word.create({ word_name: "Dawn" })
# Word.create({ word_name: "Night" })
# Word.create({ word_name: "Day" })

# Word.create({ word_name: "Sun" })
# Word.create({ word_name: "Moon" })
# Word.create({ word_name: "Star" })
# Word.create({ word_name: "Sky" })

# Word.create({ word_name: "Winter" })
# Word.create({ word_name: "Spring" })
# Word.create({ word_name: "Summer" })
# Word.create({ word_name: "Autumn" })

# Translation.create({language_id: Language.find_by(name: "").id, word_id: Word.find_by(name: "").id, translation: "", romanization: "", link: "", etymology: "", gender: "" })

puts "Seeded database."
