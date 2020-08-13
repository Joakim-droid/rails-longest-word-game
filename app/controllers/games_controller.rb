require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].gsub(' ', '').split('')
    if included?(@letters, @word)
      if is_an_english_word?(@word)
        @score = 'congrats!'
      else
        @score = "#{@word} is not an english word"
      end
    else
      @score = "#{@word} can't be built from"
    end
  end

  private

  def included?(letters, word)
    word.split('').all? { |letter| letters.include? letter }
  end

  def is_an_english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    if JSON.parse(response.read)['found']
      true
    else
      false
    end
  end
end
