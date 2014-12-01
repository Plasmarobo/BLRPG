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
    skill = Skill.find(param[:id])
    if params[:confirm] == "yes"
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
