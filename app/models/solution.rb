require_relative "mad_lib"

class Solution < ApplicationRecord
  has_one :mad_lib
  def initialize(*args)
    super(*args)
    @hash = Hash.new
  end

  def fill_field(f, v)
    #takes field and value and adds the destructured* value to the
    #hash with the key of the field
    #
    # *is destructuring a word/thing in ruby?
    @hash[f] = v[:with]
  end

  def resolve
    madlib_text = MadLib.find(self.mad_lib_id).text
    madlib_hash = MadLib.find(self.mad_lib_id).buildhash

    @hash.each do |k, v|
      madlib_hash[k] = v
    end
   
    #maybe a little janky but the Solution's hash is out of order
    #(because of the order it was populated) but the MadLib's hash
    #is in order, so we can just iterate over it and expect it to
    #be in the same order as the template words in the original text

    madlib_hash.each do |k, v|
      madlib_text.sub!(/{[^}]+}/, v)
    end
    
    return madlib_text
  end
end
