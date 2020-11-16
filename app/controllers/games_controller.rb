require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @score = 0
    @answer = params[:answer]
    if !english_word?(@answer)
      @message = "Sorry but #{@answer} does not seem to be a valid English word..."
    elsif included?(@answer, @letters.to_s)
      @message ="Sorry but #{@answer} does not in the grid..."
    else
      @message ="Congratulations!#{@answer} is a valid!"
      # score
    end
  end

  def english_word?(answer)
    reponse = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(reponse.read)
    return json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end



end
