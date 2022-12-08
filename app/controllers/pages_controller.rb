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
      hand = drawCards(@deck_id, 2)
      @hand = hand["cards"]
    else
      card = drawCards(params["deck_id"], 1)
      @hand = params[:hand]
      raise
      @hand << card["cards"][0]
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
end
