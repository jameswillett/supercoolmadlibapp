class Report < ApplicationRecord
  def getwordtypes
    types = []
    mad_libs = MadLib.all
    mad_libs.each do |ml|
      types.concat(ml.parse)
    end
    return types
  end

  def getwords
    words = []
    solutions = Solution.all
    solutions.each do |s|
      words.concat(s.words.split("%"))
    end
    return words
  end

  def getwordcounts
    wordcounts = {}

    self.getwords.each do |word|
      unless wordcounts.key?(word)
        wordcounts[word] = 1
      else
        wordcounts[word] += 1
      end
    end
    return wordcounts
  end

  def gettypecounts
    @typecounts = {
      :Nouns => 0,
      :Verbs => 0,
      :Adjectives => 0,
      :Jobs => 0,
      :Adverbs => 0,
      :Pronouns => 0,
      :Prepositions => 0,
      :Conjunctions => 0,
      :Determiners => 0,
      :Exclamations => 0
    }

    def matchtype(type, word)
      if word.downcase.match(type.to_s.downcase.chop) != nil
        @typecounts[type] += 1
      end
    end

    self.getwordtypes.each do |word|
      @typecounts.each do |type, _|
        matchtype(type, word)
      end
    end
    return @typecounts
  end
end
