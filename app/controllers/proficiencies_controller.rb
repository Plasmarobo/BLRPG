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
    respond_to do |format|
      format.html {render :show, layout: false, locals: {proficiency: @proficiency, index: nil}}
      format.json {render json: @proficiency}
    end
  end
  
  def validated_create
    valid = true
    if params[:parent] != nil and params[:vh] != nil and params[:points] != nil
      parent = ProficiencyTemplate.find(params[:parent])
      hunter = VaultHunter.find(params[:vh])
      points = params[:points]
      if hunter.current_proficiency_points > 0
        @proficiency = parent.instance(hunter, points)
        hunter.current_proficiency_points -= 1
        hunter.save
      else
        valid = false
      end
    else
      valid = false
    end
    if valid == true
      respond_to do |format|
        format.html {render :show, layout: false, locals: {proficiency: @proficiency, index: nil}}
        format.json {render json: @proficiency}
      end
    else
      respond_to do |format|
        format.html {render inline: 'failure' }
        format.json {render inline: '{ "error":"No points remain"}', status: :expectation_failed}
      end
    end
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
  
  def validate_batch
    valid = true
    #Expect params to be a hash
    # id => {pool:0, points: 0}
    if params[:proficiencies] != nil
      params[:proficiencies].each do |key, value|
        prof = Proficiency.find(key)
        hunter = prof.vault_hunter
        new_tier = value["tier"].to_i 
        delta = new_tier - prof.tier
        if valid and hunter.current_proficiency_points >= delta and new_tier < hunter.level
          hunter.current_proficiency_points -= delta
          hunter.save
          prof.update(value)
        else
          valid = false
          break
        end
      end
    end
    if valid == true
      render inline: "ok", layout: false
    else
      render inline: "failed", layout: false
    end
  end

  def index
  end

  def show
    respond_to do |format|
      format.html {render :show, layout: false, locals: {proficiency: @proficiency, index: nil}}
      format.json {render json: @proficiency}
    end
  end

  def destroy
    if params[:confirm] == "yes"
      Proficiency.destroy(params[:id])
      render inline: "destroyed", layout: false
    else
      render inline: "no confirm", layout: false
    end
   
  end
  
  def drop
    if params[:confirm] == "yes"
      prof = Proficiency.find(params[:id])
      hunter = prof.vault_hunter
      hunter.current_proficiency_points += prof.tier
      hunter.save
      prof.destroy
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
