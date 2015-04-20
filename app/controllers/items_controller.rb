class ItemsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def index
    @armor = ArmorTemplate.all
    @consumables = ConsumableTemplate.all
    @gear = GearTemplate.all
    @shields = ShieldTemplate.all
    @weapons = WeaponTemplate.all
  end
  
  def list
    @armor = ArmorTemplate.all
    @consumables = ConsumableTemplate.all
    @gear = GearTemplate.all
    @shields = ShieldTemplate.all
    @weapons = WeaponTemplate.all
    render partial: 'items/template_list', layout: false, locals: {armor: @armor, consumables: @consumables, gear: @gear, shields: @shields, weapons: @weapons}
  end
  
   
end
