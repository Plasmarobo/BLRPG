class ProficienciesController < ApplicationController
  def new
  end

  def create
  end

  def batch
    #Expect params to be a hash
    # id => {pool:0, points: 0}
    params[:proficencies].each do |key, value|
      Proficiency.find(key).update(value)
    end
    render inline: "ok", layout: false
  end

  def index
  end

  def show
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
