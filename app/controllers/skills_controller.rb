class SkillsController < ApplicationController
  def new
    skill_temp = SkillTemplate.find(params[:template_id])
    skill_temp.instance(params[:vh])
  end

  def create
    if params[:parent] != nil and params[:vh] != nil
      parent = SkillTemplate.find(params[:parent])
      hunter = VaultHunter.find(params[:vh])
      @action = parent.instance(hunter)
    end
    render :show, layout: false
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
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
