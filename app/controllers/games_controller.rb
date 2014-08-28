class GamesController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!

  def load
    @games = Game.with_spreads
  end
  def index
    @games = Game.order("week_id")
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    2.times { @game.game_details.build }  
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game, :notice => "Successfully created game."
    else
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to @game, :notice  => "Successfully updated game."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_url, :notice => "Successfully destroyed game."
  end
end
