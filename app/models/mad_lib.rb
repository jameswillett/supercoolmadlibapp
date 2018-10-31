class MadLib < ApplicationRecord
  has_many :solutions
  def parse
    #this can probably be done with a really good regexp
    #gives us an array of templated words in the order they appear
    addingtostack = false
    fields = []
    w = ''
    self.text.chars.each do |c|
      if addingtostack && c != '}'
        w += c
      end

      if c == '{'
        addingtostack = true
      elsif c == '}'
        fields.push(w)
        w = ''
        addingtostack = false
      end
    end
    return fields
  end

  def addfieldtohash(f, i = 1)
    #makes the field pretty. if the hash already has that
    #field, method recurses with incremented number until it is unique
    prettyfield = "#{f.capitalize} (#{i}):"
    if @hash.has_key?(prettyfield)
      self.addfieldtohash(f, i+1)
    else
      @hash[prettyfield] = nil
    end
  end

  def buildhash
    #parses out the templated words and builds the
    #hash with pretty keys
    @hash = Hash.new
    self.parse.each do |f| 
      self.addfieldtohash(f)
    end
    return @hash
  end

  def has_field?(f)
    self.buildhash.has_key? f
  end
end
