require 'rubygems'
require 'quizlet'
require 'csv'

class QuizletUploader
  # csv_path string Path to the csv file on disk
  TITLE_REGEX = /title\:(.*)/
  LANG_TERM_REGEX = /term language\:(.*)/
  LANG_DEFINITION_REGEX = /definition language\:(.*)/

  def initialize(csv_path, access_token)
    Quizlet.configure({
      access_token: access_token
    })

    parse_csv(csv_path)
  end

  def parse_csv(csv_path)
    terms, definitions = [], []
    title = ""

    # Sensible defaults?
    lang_term = "en"
    lang_definition = "en"

    CSV.foreach(csv_path) do |row|
      if row.length > 0
        if row[0].match(TITLE_REGEX)
          title = row[0].match(TITLE_REGEX)[1].strip!
        elsif row[0].match(LANG_TERM_REGEX)
          lang_term = row[0].match(LANG_TERM_REGEX)[1].strip!
        elsif row[0].match(LANG_DEFINITION_REGEX)
          lang_definition = row[0].match(LANG_DEFINITION_REGEX)[1].strip!
        else
          term, definition = row
          terms << term
          definitions << definition
        end
      end
    end

    upload_to_quizlet(title, lang_term, lang_definition, terms, definitions)
  end

  def upload_to_quizlet(title, lang_term, lang_definition, terms, definitions)
    puts "Uploading the following:"
    puts "\tTitle: " + title
    puts "\tLanguage of terms: " + lang_term
    puts "\tLanguage of definitions: " + lang_definition
    puts "\tTerms: " + terms.to_s
    puts "\tDefinitions: " + definitions.to_s

    set = Quizlet.add_set({
      title: title,
      lang_terms: lang_term,
      lang_definitions: lang_definition,
      terms: terms,
      definitions: definitions
    })

    if set.has_key? 'set_id'
      puts "Set created!"
    else
      puts "------ INVALID ------"
      puts set['error_description']
    end
  end
end

csv_file = ARGV[0]
access_token = ARGV[1]

qu = QuizletUploader.new(csv_file, access_token)
