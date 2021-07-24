require 'natto'

class NattoClient
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def parsed_text
    @parsed_text = mecab_client.parse text
  end

  def words
    @words = parsed_text_rows.map { |row| build_word(row) }
  end

  def superized_sentence
    superized_words = []
    words.each do |word|
      superized_words.push("超") if word.superize?
      superized_words.push(word.text)
    end

    superized_words.join
  end

  private

  def mecab_client
    @mecab_client ||= Natto::MeCab.new
  end

  def parsed_text_rows
    rows = parsed_text.split("\n")
    rows[0...(rows.length - 1)]
  end

  def build_word(row)
    text = row.split("\t")[0]
    properties = row.split("\t")[1].split(',')
    Word.new(
      text: text,
      part_of_speech: properties[0],
      category: properties[1],
    )
  end

  class Word
    attr_reader :text, :part_of_speech, :category

    def initialize(text: nil, part_of_speech: nil, category: nil)
      @text = text
      @part_of_speech = part_of_speech
      @category = category
    end

    def superize?
      category == '自立' && (part_of_speech == '動詞' || part_of_speech == '形容詞')
    end
  end
end