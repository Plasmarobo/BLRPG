class HuntersController < ApplicationController
  before_filter :set_vault_hunter, except: [:new, 
                                            :create, 
                                            :list, 
                                            :set_vault_hunter,
                                            :vault_hunter_params,
                                            :proficiency_params,
                                            :skill_params,] 
  
  def new
    @vault_hunter = VaultHunter.new  
    @vault_hunter.user = current_user
  end
  
  def create
    @vault_hunter = VaultHunter.new(vault_hunter_params)
    @vault_hunter.set_default_values()
    @vault_hunter.user = current_user
    if @vault_hunter.save
      #default attributes
      flash[:notice] = "New hunter #{@vault_hunter.name} created"
      redirect_to action: :show, id: @vault_hunter.id
    else  
      flash[:alert] = "Something went wrong"
      redirect_to action: :new
    end
  end
  
  def build
    
  end

  def edit
    if current_user == @vault_hunter.user
      respond_to do |format|
        format.html
        format.json
      end
    else
      redirect_to '/'
    end
  end

  def show
  end
  
  def update
    if current_user == @vault_hunter.user
      
      if params[:proficiencies] != nil
        params[:proficiencies].each do |key, value|
          if not @vault_hunter.proficiencies.find(key).nil?
            Proficiency.find(key).update(value)
          end
        end
      end
      
      if params[:skills] != nil
        params[:skills].each do |key, value|
          if not @vault_hunter.skills.find(key).nil?
            Skill.find(key).update(value)
          end
        end
      end
      
      if params[:minions] != nil
        params[:minions].each do |key, value|
          if not @vault_hunter.skills.find(key).nil?
            Minion.find(key).update(value)
          end
        end
      end

      update_set = vault_hunter_params
      
      if not update_set[:level].nil?
        #Recompute totals
        @vault_hunter.recompute_totals(update_set[:level])
      end
      if @vault_hunter.update(update_set)
        render inline: "ok", layout: false
      else
        render inline: "failed", layout: false
      end
    else
      render inline: "failed", layout: false
    end
  end
  
  def validate_proficiency_changes
    result = true
    #Format: template_id
    new_proficiencies = params[:new_proficiencies]
    #Format: id, points
    changed_proficiencies = params[:changed_proficiencies]
    new_proficiencies.each do |candiate|
      if not @vault_hunter.add_proficiency(candidate) then
        result = false
      end
    end
    changed_proficiencies.each do |candiate|
      if not @vault_hunter.set_proficiency(candidate.id, candidate.points) then
        result = false
      end
    end
    if result == true then
      render :inline, "success"
    else
      render :inline, "invalid"
    end
  end
  
  def validate_skill_changes
    result = true
    new_skills = params[:skills]
    new_skills.each do |candidate_id|
      candidate = SkillTemplate.find(candidate_id)
      if not @vault_hunter.add_skill(candidate) then
        result = false
      end
    end
    if result == true then
      render :inline, "success"
    else
      render :inline, "invalid"
    end
  end

  def delete
    if params[:confirm] == "yes"
      if current_user == @vault_hunter.user
        @vault_hunter.destroy
        redirect_to '/hunters/list', notice: "Destroyed #{@vault_hunter.name}"
      end
    end
  end
  
  def addskill
    if @vault_hunter.current_skill_points > 0
      skill = SkillTemplate.find(skill_params)
      if (skill != nil)
        if @vault_hunter.meets_prereq?(skill)
          if skill.instance(@vault_hunter)
            render html: "Success", status: 201
          else
            render html: "Failure", status: 500
          end
        else
          render html: "Prerequisite not met", status: 406
        end
      else
        render html: "Unknown Skill", status: 400
      end
    else
      render html: "No skill points available.", status: 200
    end
  end
  
  def dropskill
  end
  
  def addproficiency
    if @vault_hunter.current_proficiency_points > 0
      proficiency = ProficiencyTemplate.find(proficiency_params)
      if (proficiency != nil)
        if proficiency.instance(@vault_hunter)
          render html: "Success", status: 201
        else
          render html: "Failure", status: 500
        end
      else
        render html: "Unknown Skill", status: 400
      end
    else
      render html: "No proficiency points available.", status: 200
    end
  end
  
  def dropproficiency
  end
  
  def addweapon
    weapon = WeaponTemplate.find(params.require(:weapon_template_id))
    tryAddItem(weapon)
  end
  
  def dropweapon
    weapon = WeaponInstance.find(params.require(:weapon_instance_id))
    tryDelete(params, weapon)
  end
  
  def addarmor
    armor = ArmorTemplate.find(params.require(:armor_template_id))
    tryAddItem(armor)
  end
  
  def droparmor
    armor = ArmorInstance.find(params.require(:armor_instance_id))
    tryDelete(params, armor)
  end
  
  def addconsumable
    consumable = ConsumableTemplate.find(params.require(:consumable_template_id))
    tryAddItem(consumable)
  end
  
  def dropconsumable
    consumable = ConsumableInstance.find(params.require(:consumable_instance_id))
    tryDelete(params, consumable)
  end
  
  def addshield
    shield = ShieldTemplate.find(params.require(:shield_template_id))
    tryAddItem(shield)
  end
  
  def dropshield
    shield = ShieldInstance.find(params.require(:shield_instance_id))
    tryDelete(params, shield)
  end
  
  def addgear
    gear = GearTemplate.find(params.require(:gear_templated_id))
    tryAddItem(gear)
  end
  
  def dropgear
    gear = GearInstance.find(params.require(:gear_instance_id))
    tryDelete(params, gear)
  end

  def list
    @vault_hunters = current_user.vault_hunters
    render :list
  end

  def listskills
    render partial: 'skills/edit_list', locals: {skills: @vault_hunter.skill_instances}
  end
  
  def listproficiencies
    render partial: 'proficiencies/edit_list', locals: {proficiencies: @vault_hunter.proficiency_instances}
  end
  
  def listweapons
    render partial: 'weapons/instance_list', locals: {weapons: @vault_hunter.weapon_instances}
  end
  
  def listarmors
    render partial: 'armor/instance_list', locals: {armors: @vault_hunter.armor_instances}
  end
  
  def listconsumables
    render partial: 'consumables/instance_list', locals: {consumables: @vault_hunter.consumable_instances}
  end
  
  def listshields
    render partial: 'shields/instance_list', locals: {shields: @vault_hunter.shield_instances}
  end
  
  def listgears
    render partial: 'gear/instance_list', locals: {gears: @vault_hunter.gear_instances}
  end
  
  def inventory
    render partial: 'items/instance_list', locals: {weapons: @vault_hunter.weapon_instances, armor: @vault_hunter.armor_instances, consumables: @vault_hunter.consumable_instances, gear: @vault_hunter.gear_instances, shields: @vault_hunter.shield_instances}
  end

  #All skills who's prerequsties are met
  def potentialskills
    @skills = SkillTemplate.all.to_a
    @skills.select! do |skill|
      (!@vault_hunter.has_skill?(skill.name)) and @vault_hunter.meets_prereq?(skill)
    end
    render partial: 'skills/template_list', layout: false, locals: {skills: @skills}
  end
  
  def potentialproficiencies
    @proficiencies = ProficiencyTemplate.all.to_a
    @proficiencies.select! do |prof|
      (!@vault_hunter.has_proficiency?(prof.name))
    end
    render partial: 'proficiencies/template_list', layout: false, locals: {proficiencies: @proficiencies}
  end

  private
    def vault_hunter_params
      params.require(:vault_hunter).permit(:name, 
                                          :level, 
                                          :user_id, 
                                          :age, 
                                          :eyes,
                                          :hair,
                                          :skin,
                                          :race_id, 
                                          :height, 
                                          :weight, 
                                          :toughness, 
                                          :wounds,
                                          :loot, 
                                          :money,
                                          :description,
                                          :background,
                                          :traits,
                                          :flaws)
    end
    
    def skill_params
      params.require(:skill_template_id)
    end
    
    def proficiency_params
      params.require(:proficiency_template_id)
    end
    
    def set_vault_hunter
      @vault_hunter = VaultHunter.find(params[:id])
      if not current_user || (current_user.id != @vault_hunter.user_id)
        render html: "Current User not Owner", status: 403
      end
    end
    
    def tryAddItem(item)
      if item != nil
        if @vault_hunter.money >= item.cost
          if item.instance(@vault_hunter)
            #@vault_hunter.money = @vault_hunter.money - item.cost
            render html: "Success", status: 201
          else
            render html: "Failure", status: 500
          end
        else
          render html: "Insufficient funds", status: 200
        end
      else
        render html: "Unknown item", status: 400
      end
    end
    
    def tryDelete(params, item)
      if params[:confirm] == "yes"
        if current_user == @vault_hunter.user_id
          item.destroy
          render html: "Destroyed", status: 201
        else
          render html: "Current User not Onwer", status: 403
        end
      else
        render html: "Cancled", status: 200
      end
    end
end
