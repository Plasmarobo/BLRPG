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
  
  def update
    params.require(:batch).each do |key, updates|
      consumable = ConsumableInstance.find(key)
      if consumable != nil
        if consumable.checkOwner(current_user)
          updates = updates.permit(:current_uses)
          consumable.update(updates)
        end
      else
        render html: "Unknown item #{key}", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end
end
