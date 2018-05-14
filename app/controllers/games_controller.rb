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


  def score
    @our_word = params[:our_word]
    @our_letters = params[:our_letters]

    if is_in_new?(@our_word, @our_letters) && is_english?(@our_word)
      return "Good, this is a valid word"
    elsif !is_in_new?(@our_word, @our_letters) && is_english?(@our_word)
      return "Word can't be made from grid, but is a word"
    elsif !is_english?(@our_word) && is_in_new?(@our_word, @our_letters)
      return "This is from the grid, but not a real word"
    else
      return "Neither valid nor real word"
    end
  end
end
