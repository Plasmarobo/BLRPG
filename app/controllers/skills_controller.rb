class SkillsController < ApplicationController
  def new
    skill_temp = SkillTemplate.find(params[:template_id])
    skill_temp.instance(params[:vh])
  end

  def create
  end

  def batch
    params[:skills].each do |key, value|
      Skill.find(key).update(value)
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
