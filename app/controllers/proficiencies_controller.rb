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
  
  def delete
    params.require(:id)
    prof = ProficiencyInstance.find(params[:id])
    if (prof == nil)
      render html: "Unkown item", status: 400
    else
      prof.destroy()
      render html: "Deleted", status: 200
    end
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
          updates = ActionController::Parameters.new(updates).permit(:tier, :value, :category)
          prof.update(updates)
        else
          render html: "Current User not Owner", status: 403
          return
        end
      else
        render html: "Unknown proficiency #{key}", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end
  
  def card
    params.require(:id)
    @proficiency = ProficiencyTemplate.find(params[:id])
    @meta = {}
    @meta[:color] = "#F0B756"
    @meta[:title] = @proficiency.name
    @meta[:subtitle] = "Noncombat abilities"
    render partial: 'proficiencies/card', locals: {proficiency: @proficiency}, layout: 'layouts/card'
  end
  
  private
  
  def hunter_params
    params.permit(:vault_hunter_id)
  end

end
