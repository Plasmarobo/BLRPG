class SkillsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def index
  end

  def card
  end
  
  def instance
  end
  
  def prerequsites
  end
  
  def upgrades
  end
  
  def edit_list
    hunter = VaultHunter.find(hunter_params[:vault_hunter_id])
    if not hunter.nil?
      render partial: 'edit_list', locals: {skills: hunter.skill_instances}
    end
  end
  
  private
  
  def hunter_params
    params.permit(:vault_hunter_id)
  end
  
end
