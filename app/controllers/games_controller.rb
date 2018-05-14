class GamesController < ApplicationController
  def new
    alphabet = ("A".. "Z").to_a
    @letters = []
    while @letters.length < 10
      @letters.push(alphabet.sample)
    end
    @letters
  end

  def score
    raise
  end
end
