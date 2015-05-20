class MinionsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def index
  end

  def card
    params.require(:id)
    @minion = MinionTemplate.find(params[:id])
    @meta = {}
    @meta[:color] = "#D4CF3F"
    @meta[:title] = @minion.name
    @meta[:subtitle] = MinionTemplate.size_description
    render partial: 'minions/card', locals: {minion: @minion}, layout: 'layouts/card'
  end
  
  def instance
  end
end
