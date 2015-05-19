class WeaponsController < ApplicationController
  before_action :set_weapon, only: ["delete"]
  
  def new
  end

  def create
  end

  def index
  end

  def edit
  end
  
  def delete
    if (@weapon == nil)
      render html: "Unkown item", status: 400
    else
      @weapon.destroy()
      render html: "Deleted", status: 200
    end
  end

  def card
    params.require(:id)
    prefix = ""
    postfix = ""
    if params[:template] == true
      @weapon = WeaponTemplate.find(params[:id])
    else
      inst = WeaponInstance.find(params[:id])
      @weapon = inst.weapon_template
      prefix = inst.prefix
      postfix = inst.postfix
    end
    @meta = {}
    @meta[:color] = "#D65454"
    @meta[:title] = prefix + @weapon.name + postfix
    @meta[:subtitle] = "Shreds flesh and bone"
    render partial: 'weapons/card', locals: {weapon: @weapon}, layout: 'layouts/card'
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
    
    def set_weapon
      params.require(:id)
      @weapon = WeaponInstance.find(params[:id])
    end
end
