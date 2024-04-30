require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    @score_and_message = score_and_message(@word, @letters)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score_and_message(word, letters)
    if included?(word.upcase, letters)
      if english_word?(word)
        "Congratulations! #{word} is a valid English word!"
      else
        "Sorry but #{word} does not seem to be a valid English word..."
      end
    else
      "Sorry but #{word} can't be built out of #{letters}"
    end
  end
end
