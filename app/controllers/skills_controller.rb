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
  
  def update
    params.require(:batch).each do |key, updates|
      skill = SkillInstance.find(key)
      if skill != nil
        if skill.checkOwner(current_user)
          updates = ActionController::Parameters.new(updates).permit(:duration, :cooldown)
          skill.update_status(updates[:duration], updates[:cooldown]);
        else
          render html: "Current User not Owner", status: 403
          return
        end
      else
        render html: "Unknown skill #{key}", status: 400
        return
      end
    end
    render html: "Batch accepted", status: 200
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
