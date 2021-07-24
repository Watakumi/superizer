require 'natto'

class NattoClient
  attr_accessor :text, :parsed_text, :words

  def initialize(text)
    @text = text
    parse
  end

  def parse
    mecab_client = Natto::MeCab.new
    @parsed_text = mecab_client.parse @text
    @words = parsed_text_rows.map { |row| build_word(row) }
    @parsed_text
  end

  private

  def parsed_text_rows
    rows = @parsed_text.split("\n")
    rows[0...(rows.length - 1)]
  end

  def build_word(row)
    text = row.split("\t")[0]
    properties = row.split("\t")[1].split(',')
    Word.new(
      text: text,
      category1: properties[0],
      category2: properties[1],
      category3: properties[2]
    )
  end

  class Word
    attr_reader :text, :category1, :category2, :category3

    def initialize(text: nil, category1: nil, category2: nil, category3: nil)
      @text = text
      @category1 = category1
      @category2 = category2
      @category3 = category3
    end

    def noun?
      @category1 == "名詞"
    end

    def number?
      @category2 == '数'
    end
  end
end