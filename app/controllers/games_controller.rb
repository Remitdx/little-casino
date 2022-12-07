class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.create!(user: current_user, gold: 1000, name: "New game")
    redirect_to game_path(@game)
  end

end
