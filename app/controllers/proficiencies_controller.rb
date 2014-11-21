class ProficienciesController < ApplicationController
  def new
  end

  def create
    if params[:parent] != nil and params[:vh] != nil and params[:points]
      parent = ProficiencyTemplate.find(params[:parent])
      hunter = VaultHunter.find(params[:vh])
      points = params[:points]
      @proficiency = parent.instance(hunter, points)
    end
    render :show, layout: false, locals: {proficiency: @proficiency, index: nil}
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
    render :show, locals: {proficiency: @proficiency, index: nil}
  end

  def destroy
    if params[:confirm] == "yes"
      Proficiency.destroy(params[:id])
      render inline: "destroyed", layout: false
    else
      render inline: "no confirm", layout: false
    end
   
  end

  def edit
    render :edit, locals: {proficiency: @proficiency, index: nil}
  end

  def update
  end
end
