class RacesController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def index
  end
  
  def list
    render partial: 'list', locals: {races: Race.all}
  end

  def card
    params.require(:id)
    @race = Race.find(params[:id])
    @meta = {}
    @meta[:color] = "#9BCBCC"
    @meta[:title] = @race.name
    @meta[:subtitle] = "It's like bugspray for bullets"
    render partial: 'races/card', locals: {race: @race}, layout: 'layouts/card'
  end
  
  def instance
  end
end
