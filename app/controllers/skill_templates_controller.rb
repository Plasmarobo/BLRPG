class SkillTemplatesController < ApplicationController
  before_filter :set_skill_template, only: [:show, :edit, :update, :destroy]

  def index

  end

  def list
    @skills = SkillTemplate.all
    respond_to do |format|
      format.html {render layout: nil}
      format.json
    end
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

    def set_skill_template
      @skill_template = SkillTemplate.find(params[:id])
    end

    def skill_template_params
      params.require(:skill_template).permit(:name, :skill_type, :cooldown, :duration, :description)
    end
end
