class ArmorController < ApplicationController
  
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
    armor = ArmorInstance.find(params[:id])
    if (armor == nil)
      render html: "Unkown item", status: 400
    else
      armor.destroy()
      render html: "Deleted", status: 200
    end
  end
  
  def update
    params.require(:batch).each do |key, updates|
      armor = ArmorInstance.find(key)
      if armor != nil 
        if armor.checkOwner(current_user)
          updates = ActionController::Parameters.new(updates).permit(:current_deflect, :in_use)
          armor.update(updates)
        else
          render html: "Current User not Owner", status: 403
          return
        end
      else
        render html: "Unknown armor #{key}", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end

end
