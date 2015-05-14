class WeaponsController < ApplicationController
  def new
  end

  def create
  end

  def index
  end

  def edit
  end

  def card
  end
  
  def update
    params.require(:batch).each do |key, updates|
      weapon = WeaponInstance.find(key)
      if weapon != nil 
        if weapon.checkOwner(current_user)
          weapon.update(weapon_params(ActionController::Parameters.new(updates)))
        else
          render html: "Current User not Owner", status: 403
          return
        end
      else
        render html: "Unknown item", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end
  
  def instance
  end
  
  private 
    def weapon_params(params)
      params.permit(:ammunition,
                    :notes,
                    :prefix,
                    :postfix,
                    :current_recoil)
    end
end
