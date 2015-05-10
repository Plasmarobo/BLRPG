class ProficienciesController < ApplicationController
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
  
  def edit_list
    hunter = VaultHunter.find(hunter_params[:vault_hunter_id])
    if not hunter.nil?
      render partial: 'edit_list', locals: {proficiencies: hunter.proficiency_instances}
    end
  end
  
  def update
    params.require(:batch).each do |key, updates|
      prof = ProficiencyInstance.find(key)
      if prof != nil
        if prof.checkOwner(current_user)
          updates = updates.permit(:tier, :value, :category)
          prof.update(updates)
        end
      else
        render html: "Unknown proficiency #{key}", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end
  
  private
  
  def hunter_params
    params.permit(:vault_hunter_id)
  end

end
