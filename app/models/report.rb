class Report < ApplicationRecord
  def getwordtypes
    types = []
    MadLib.all.each do |ml|
      solutions_count = Solution.where(mad_lib_id: ml.id).size
      types.push({:num => solutions_count, :words => ml.parse})
    end
    return types
  end

  def getwords
    words = []
    Solution.all.each do |s|
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
    return wordcounts.sort_by {|_, v| -v}.to_h
  end

  def gettypecounts
    @typecounts = {
      :Nouns => 0,
      :Verbs => 0,
      :Adjectives => 0,
      :Jobs => 0,
      :Animals => 0,
      :Adverbs => 0,
      :Pronouns => 0,
      :Prepositions => 0,
      :Conjunctions => 0,
      :Determiners => 0,
      :Exclamations => 0
    }

    def matchtype(type, words, num)
      words.each do |word|
        if word.downcase.match(type.to_s.downcase.chop) != nil
          @typecounts[type] += num
        end
      end
    end

    self.getwordtypes.each do |hash|
      num = hash[:num]
      words = hash[:words]
      @typecounts.each do |type, _|
        matchtype(type, words, num)
      end
    end
    return @typecounts.sort_by {|_, v| -v}.to_h
  end
end
