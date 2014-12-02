class SkillsController < ApplicationController
  before_filter :set_skill, only: [:show, :edit]
  def new
    skill_temp = SkillTemplate.find(params[:template_id])
    skill_temp.instance(params[:vh])
  end

  def create
    if params[:parent] != nil and params[:vh] != nil
      parent = SkillTemplate.find(params[:parent])
      hunter = VaultHunter.find(params[:vh])
      @skill = parent.instance(hunter)
    end
    render :show, layout: false, locals: {skill: @skill, index: nil}
  end
  
  def validated_create
    valid = true
    if params[:parent] != nil and params[:vh] != nil
      parent = SkillTemplate.find(params[:parent])
      hunter = VaultHunter.find(params[:vh])
      if hunter.current_skill_points > 0
        hunter.current_skill_points -= 1
        hunter.save
        @skill = parent.instance(hunter)
      else
        valid = false
      end
    else
      valid = false
    end
    if valid == true
      respond_to do |format|
        format.html {render :show, layout: false, locals: {skill: @skill, index: nil}}
        format.json 
      end
    else
      respond_to do |format|
        format.html {render inline: 'failure' }
        format.json {render inline: '{ "error":"No points remain"}', status: :expectation_failed}
      end
    end
  end

  def batch
    if params[:skills] != nil
      params[:skills].each do |key, value|
        Skill.find(key).update(value)
      end
    end
    render inline: "ok", layout: false
  end

  def index
  end

  def show
    render :show, locals: {skill: @skill, index: nil}
  end

  def destroy
    skill = Skill.find(params[:id])
    if params[:confirm] == "yes"
      skill.destroy
      render inline: "destroyed", layout: false
    else
      render inline: "no confirm", layout: false
    end
    
  end
  
  def drop
    skill = Skill.find(params[:id])
    if params[:confirm] == "yes"
      vh = skill.vault_hunter
      vh.current_skill_points += 1
      vh.save
      skill.destroy
      render inline: "destroyed", layout: false
    else
      render inline: "no confirm", layout: false
    end
    
  end

  def edit
    render :edit, layout: false, locals: {skill: @skill, index: nil}
  end

  def update
  end
  
  private
    def set_skill
      @skill = Skill.find(params[:id])
    end
end
