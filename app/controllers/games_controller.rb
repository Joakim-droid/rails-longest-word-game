require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].gsub(' ', '').split('')
    if included?(@letters, @word)
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    if JSON.parse(response.read)['found']
      if an_english_word?(@word)
        raise
        @score = 'congrats!'
      else
        @score = '  not an english word'
      end
    else
      @score = "#{@word} can't be built from"
    end
  end

  def included?(letters, word)
    word.split('').all? { |letter| letters.include? letter }
  end
end
