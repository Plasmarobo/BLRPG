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
  end
  
  def instance
  end
end
