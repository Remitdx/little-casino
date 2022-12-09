require 'httparty'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def blackjack
    if params["start"].nil?
      @hand = []
    elsif params["start"] == "true"
      @deck_id = getNewDeck
      @hand= []
      hand = drawCards(@deck_id, 2)
      hand["cards"].each do |card|
        @hand << card["code"]
      end
      @score = scoreCalculation(@hand)
    else
      card = drawCards(params["deck_id"], 1)
      @deck_id = params[:deck_id]
      @hand = params[:hand]
      @hand << card["cards"][0]["code"]
      @score = scoreCalculation(@hand)
    end
  end

  def roulette
  end

  def poker
  end

  private

  def getNewDeck
    url = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=6"
    response = HTTParty.get(url)
    response.parsed_response["deck_id"]
  end

  def drawCards(deck_id, n)
    url = "https://www.deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=#{n}"
    response = HTTParty.get(url)
    response.parsed_response
  end

  def scoreCalculation(hand)
    score = 0
    hand.each do |card|
      if card[0].match?("A")
        if score > 11
          score += 1
        else
          score += 10
        end
      elsif card[0].match?(/[A-Z]|0/)
        score += 10
      else
        score += card[0].to_i
      end
    end
    return score
  end
end
