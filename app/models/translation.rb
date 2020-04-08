# encoding: utf-8
class Translation < ApplicationRecord
  belongs_to :language
  belongs_to :word

  validates :translation, presence: true
  validates :link, presence: true

  require "open-uri"

  def self.find_info(chosen_word)
    t1 = Time.now

    query_page = Nokogiri::HTML(open("https://en.wiktionary.org/wiki/#{chosen_word}#Translations"))

    etymology_english = query_page.css("[id^='Etymology']")[0].parent.next_element.text
    # word_id = Word.find_or_create_by(word_name: chosen_word).id

    # Translation.create({ language_id: 1, word_id: word_id, translation: chosen_word, romanization: chosen_word, link: "https://en.wiktionary.org/wiki/#{chosen_word}#Translations", etymology: etymology_english, gender: nil })

    # layout2 = page.find("#{chosen_word}/translations § Noun")
    path1 = query_page.xpath('//a[contains(text(), "/translations § Noun")]')
    path2 = query_page.xpath('//a[contains(text(), "/translations#Noun")]')

    if path1.length > 0
      layout_path = path1[0]["href"]
    end
    if path2.length > 0
      layout_path = path2[0]["href"]
    end

    if !layout_path.nil?
      puts "if fires"
      # layout_alt = query_page.xpath('//a[contains(text(), "/translations § Noun")]')[0]["href"]
      page = Nokogiri::HTML(open("https://en.wiktionary.org#{layout_path}"))
    else
      puts " => else fires"
      page = Nokogiri::HTML(open("https://en.wiktionary.org/wiki/#{chosen_word}#Translations"))
    end

    first_table1 = page.css("td.translations-cell")[0].children.children
    second_table1 = page.css("td.translations-cell")[1].children.children

    all_li_array = []
    first_table1.each do |item|
      if item.to_s != "\n"
        all_li_array << item
      end
    end

    second_table1.each do |item|
      if item.to_s != "\n"
        all_li_array << item
      end
    end

    definition = page.css("table.translations")[0].attributes["data-gloss"].value
    word_id = Word.find_by(word_name: chosen_word ).id
    @word = Word.find(word_id)
    @word.update(definition: definition)
    Translation.create({ language_id: 1, word_id: word_id, translation: chosen_word, romanization: chosen_word, link: "https://en.wiktionary.org/wiki/#{chosen_word}#Translations", etymology: etymology_english, gender: nil })

    puts "=================================================================="
    puts "Word: #{chosen_word}"
    puts "Definition: #{definition}"
    puts "Li Count: #{all_li_array.count}"
    # word_id = Word.find_or_create_by(name: chosen_word).id
    puts "Word ID: #{word_id}"

    errors_ar = []

    # English moved to above
    # etymology_eng = page.css("span#Etymology")[0].parent.next_element.text
    # etymology_english = page.css("[id^='Etymology']")[0].parent.next_element.text
    #  Translation.create({language_id: 1, word_id: word_id, translation: chosen_word, romanization: chosen_word, link: "https://en.wiktionary.org/wiki/#{chosen_word}#Translations", etymology: etymology_english, gender: nil })

    # NEED: language_id, word_id, translation, romanization, full_link_eng, etymology, gender

    all_li_array.each_with_index do |li, index|
      etymology = nil

      language_name = li.text.split(":")[0]

      # if ['Azerbaijani', 'Chinese'].include?(language_name)

      if li.css("span.gender")[0]&.text
        gender = li.css("span.gender")[0].text
      else
        gender = nil
      end

      # fix serbo-croat here

      if li.css("span")[0]&.text && li.css("span")[0]&.text != "please add this translation if you can"
        translation = li.css("span")[0]&.text.gsub(/\(compound\)/, "").gsub(/\(please verify\)/, "").strip
      else
        translation = nil
      end

      if !li.css("span.tr.Latn")[0].nil?
        romanization = li.css("span.Latn")[0].text
      else
        romanization = translation
      end

      # if li.children[1].children[0].attributes["href"]&.value
      if !li.css("a")[0].nil? && li.css("a")[0]&.attributes["href"]&.value
        short_link_eng = li.css("a")[0]&.attributes["href"].value
      else
        short_link_eng = nil
      end
      # => "/wiki/goud#Afrikaans" || nil

      if !short_link_eng.nil?
        full_link_eng = "https://en.wiktionary.org" << short_link_eng
        if language_name.include?("'") || language_name.include?("(")
          etymology_page = nil
        elsif full_link_eng.ascii_only? && !full_link_eng.include?("&action=edit")
          etymology_page = Nokogiri::HTML(open(full_link_eng))
        else
          etymology_page = nil
        end
      end
      # "https://en.wiktionary.org/wiki/goud#Afrikaans" || nil

      language_name_span_id = language_name.split(" ").join("_")
      # format the name to the wiktionary style

      if !etymology_page.nil? && etymology_page.css("[id=#{language_name_span_id}]").length > 0 && etymology_page.css("[id^='Etymology']").length > 0
        # if the page exists, and the page has the language on it, and there is an etymology element
        current_element = etymology_page.css("[id=#{language_name_span_id}]")[0]&.parent.next_element
        # get the element with the id of the language_name, which is a SPAN under h2 with the lang_name. then, get the parent, the h2 tag, and then the next element. I need the current element to not be a h2, because that is my stop sign. Some pages have another h2 beneath with an ety from another lang. This is not right. This way, NULL goes in the DB, which is right, and not a wrong value.
        while !current_element.nil? && current_element.name != "h2"
          if current_element.name == "h3" && current_element.text.include?("Etymology") && !current_element.next_element.text.include?("(This etymology is missing or incomplete.")
            # usually it is a h3 with etymology, then the next p tag that has the etymology. But not always. This gets the h3 tag, and loops until it finds the p tag, THEN takes the value.
            while !current_element.nil? && current_element.name != "p" && current_element.name != "div"
              current_element = current_element.next_element
            end
            etymology = current_element.text.strip
            break
          end
          current_element = current_element.next_element
        end
      else
        etymology = nil
      end

      language_id = Language.find_or_create_by!(name: language_name).id

      @translation = Translation.new({ language_id: language_id, word_id: word_id, translation: translation, romanization: romanization, link: full_link_eng, etymology: etymology, gender: gender })

      if !full_link_eng.nil? && @translation.save
        puts "\n"
        puts "language_id: #{language_id}"
        puts "#{index + 1}. Lang: #{language_name} - Trans: #{translation ? translation : "NONE"} - Roman: #{romanization} - Gender: #{gender ? gender : "NONE"} - Ety: #{etymology ? etymology : "NONE"}"
        puts "\n"
        puts "==================================================="
        puts "\n"
      else
        puts "Translation not saved for #{language_name}"
        puts "Errors= #{@translation.errors.full_messages.join(", ")}"
        error_hash = {}
        error_hash[language_name] = @translation.errors.full_messages
        errors_ar << error_hash
      end
    end
    t2 = Time.now
    time = t2 - t1
    puts "+++++++++++++++++++++"
    puts "\nDONE with <<< #{chosen_word}, #{definition} >>> \n"
    puts "Count: #{all_li_array.count} entries"
    puts "in #{time.round(2)} seconds"
    puts "Errors: #{errors_ar}"
  end

  # # # # # # # # # # # # # # # # # # # #

  # Find all translations of a word in All languages
  def self.find_all_translations(query)
    word_id = Word.find_by("word_name = ?", query.downcase).id
    Translation.joins(:language).where(word_id: word_id).order(:name)
  end

  # all translations of a WORD in a MACROFAMILY.
  def self.find_all_genders(word_name, macrofamily = "Indo-European")
    word_id = Word.find_by(word_name: word_name.downcase).id
    Translation.joins(:language).where("word_id = ? AND macrofamily = ?", word_id, macrofamily).order(:family)
  end

  # etymologies that contain the query word inside.
  def self.find_etymology_containing(query)
    Translation.where("etymology LIKE :query", query: "%#{sanitize_sql_like(query)}%")
  end

  # make a hash group by etymology
  def self.find_grouped_etymologies(query, macrofamily = "Indo-European")
    array = []
    ety_hash = Hash.new { |k, v| }
    word_id = Word.find_by("word_name = ?", query.downcase).id
    translations_array = Language.select([:id, :family, :name, :romanization, :etymology])
      .joins(:translations)
      .where("word_id = ? AND macrofamily = ?", word_id, macrofamily)
      .order(:etymology)
    # can I make a hash of these server side?
    # why doesnt etymology appear when look at translations_array?
    translations_array.each do |translation|
      if translation.etymology.nil?
        short_etymology = "Null"
      else
        short_etymology = translation.etymology.strip
        # short_etymology = translation.etymology.slice(0,60).strip
      end
      if ety_hash[short_etymology]
        ety_hash[short_etymology] << translation.name
      else
        ety_hash[short_etymology] = [translation.name]
      end
    end
    ety_hash.each do |h|
      array << h
    end
    pp ety_hash
    array
  end

  # all the translations of EVERY WORD in a macrofamily
  def self.find_all_translations_by_macrofamily(macrofamily)
    Translation.joins(:word, :language).select("translations.*, languages.*, words.word_name").where("macrofamily = ?", macrofamily).order(:family, :word_name)
  end

  # all the translations in a specified language
  def self.find_all_translations_by_language(language)
    language_id = Language.find_by(name: language.titleize).id
    Translation.joins(:word).select("translations.*, words.word_name").where("language_id = ?", language_id).order(:romanization)
  end

  # find all the translations of the word_name && are in location in area1, area2, area3.
  def self.find_all_translations_by_area(location, word_name)
    word_id = Word.find_by(word_name: word_name.downcase).id
    # below gives wrong translation id. It gives the language id instead
    Translation.joins(:language, :word).select("translations.*, translations.id as t_id, languages.*, words.word_name").where("area1 = ?", location).or(Translation.joins(:language, :word).select("translations.*, translations.id as t_id, languages.*, words.word_name").where("area2 = ?", location)).or(Translation.joins(:language, :word).select("translations.*, translations.id as t_id, languages.*, words.word_name").where("area3 = ?", location)).where("word_id = ?", word_id).order(:macrofamily, :family)
    # The one below only gives all of the translations table
    # Translation.joins(:language, :word).where("area1 = ?", location).or(Translation.joins(:language, :word).where("area2 = ?", location)).or(Translation.joins(:language, :word).where("area3 = ?", location)).where("word_id = ?", word_id).order(:macrofamily, :family)
  end

  # find all the translations that inclue the location in area1, area2, area3.
  def self.find_all_translations_by_area_img(location, word_name)
    result_array = []
    etymology_array = []

    word_id = Word.find_by("word_name = ?", word_name.downcase).id
    search_results = Translation.joins(:language).select("languages.abbreviation, translations.translation, translations.etymology").where("area1 = ?", location).or(Translation.joins(:language).select("languages.abbreviation, translations.translation, translations.etymology").where("area2 = ?", location)).or(Translation.joins(:language).select("languages.abbreviation, translations.translation, translations.etymology").where("area3 = ?", location)).where("word_id = ?", word_id).order(:abbreviation)

    # example nl water green
    search_results.each do |result|
      if !result.etymology.nil? || !result.etymology == "Null"
        etymology = result.etymology&.strip 
        if etymology_array.any? { |ety| ety && ety.include?(etymology.to_s) }
          # puts "in if"
          # byebug
          index = etymology_array.find_index{ |ety| ety && ety.include?(etymology.to_s) }
          result_array << ["#{result.abbreviation}", "#{result.translation}", index.to_i]
        else
          # puts "in else"
          # byebug
          etymology_array << etymology
          result_array << ["#{result.abbreviation}", "#{result.translation}", etymology_array.length.to_i]
        end
      else
        result_array << ["#{result.abbreviation}", "#{result.translation}", nil]
      end
      # byebug
    end
    result_array
  end

  # All genders in an area
  def self.find_all_genders_by_area_img(location, word_name)
    result_array = []

    word_id = Word.find_by("word_name = ?", word_name.downcase).id
    search_results = Translation.joins(:language).select("languages.abbreviation, translations.translation, translations.gender").where("area1 = ?", location).or(Translation.joins(:language).select("languages.abbreviation, translations.translation, translations.gender").where("area2 = ?", location)).or(Translation.joins(:language).select("languages.abbreviation, translations.translation, translations.gender").where("area3 = ?", location)).where("word_id = ?", word_id).order(:abbreviation)

    # example nl water m
    search_results.each do |result|
      result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}", gender: "#{result.gender}"}
    end
    result_array
  end

end
