class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    alphabet = ("A".. "Z").to_a
    @letters = []
    while @letters.length < 10
      @letters.push(alphabet.sample)
    end
    @letters
  end



  def score
    @our_word = params[:our_word].upcase
    @letters = params[:letters]
    @is_in_new = is_in_new?(@our_word, @letters)
    @is_english = is_english?(@our_word)
  end

    # In order to use the methods that I wrote below in the view,
    # they need to be transformed into instance variables, which can be passed
    # into the view.

  private

  def is_in_new?(string, grid)
  score_hash = {}
  grid_hash = {}
    score_array = string.split("")
    score_array.each do |letter|
      if !score_hash.include?(letter)
        score_hash[letter] = 1
      else
        score_hash[letter] += 1
      end
    end
    grid.split("").each do |letter|
      if !grid_hash.include?(letter)
        grid_hash[letter] = 1
      else
        grid_hash[letter] += 1
      end
    end
    score_hash.each do |key, value|
      if !grid_hash.include?(key)
        return false
      elsif grid_hash[key] < score_hash[key]
        return false
      end
    end
    return true
  end

  def is_english?(string)
    url = "https://wagon-dictionary.herokuapp.com/#{string}"
    potential_word = JSON.parse(open(url).read)
    potential_word["found"] == true
  end
end
