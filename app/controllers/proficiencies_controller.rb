class ProficienciesController < ApplicationController
  def new
  end

  def create
    if params[:parent] != nil and params[:vh] != nil and params[:points]
      parent = ProficiencyTemplate.find(params[:parent])
      hunter = VaultHunter.find(param[:vh])
      @proficiency = parent.instance(hunter, points)
    end
    render :show, layout: false
  end

  def batch
    #Expect params to be a hash
    # id => {pool:0, points: 0}
    if params[:proficiencies] != nil
      params[:proficiencies].each do |key, value|
        Proficiency.find(key).update(value)
      end
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
