require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    create
  end

  def score
    @answer = ""
    if included? == true
      check_api
      if @response["found"] == true
      @score = @response["length"].to_i
      @answer = "Congratulations! Your word, #{params["user_input"]}, is a valid word and your score is #{score}!"
      else
        @answer = "Not an english word"
      end
    else
      @answer = "Not included in the letters"
    end
  end

  private

  def create
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def check_api
    url = "https://wagon-dictionary.herokuapp.com/#{params['user_input']}"
    @response = JSON.parse(open(url).read)
  end

  def included?
    @array_response = params['user_input'].split("")
    @array_response.all? { |letter| @array_response.count(letter) <= params['letters'].count(letter) }
  end

end
