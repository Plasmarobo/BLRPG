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
  
  def update
    params.require(:batch).each do |key, updates|
      armor = ArmorInstances.find(key)
      if armor != nil 
        if armor.checkOwner(current_user)
          updates = updates.permit(:current_deflect, :in_use)
          armor.update(updates)
        end
      else
        render html: "Unknown armor #{key}", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end

end
