class RacesController < ApplicationController
  def list
    @races = Race.all.to_a
    render :list, layout: false
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end

end
