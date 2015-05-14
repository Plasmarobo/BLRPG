class ConsumablesController < ApplicationController
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
    consumable = ConsumableInstance.find(params[:id])
    if (weapon == nil)
      render html: "Unkown item", status: 400
    else
      consumable.destroy()
      render html: "Deleted", status: 200
    end
  end
  
  def update
    params.require(:batch).each do |key, updates|
      consumable = ConsumableInstance.find(key)
      if consumable != nil
        if consumable.checkOwner(current_user)
          updates = ActionController::Parameters.new(updates).permit(:current_uses)
          consumable.update(updates)
        else
          render html: "Current User not Owner", status: 403
          return
        end
      else
        render html: "Unknown item #{key}", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end
end
