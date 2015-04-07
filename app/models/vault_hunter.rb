class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skill_instances, dependent: :destroy
    has_many :skill_templates, through: :skill_instances
    
    has_many :proficiency_instances, dependent: :destroy
    has_many :proficiency_templates, through: :proficiency_instances
    
    has_many :weapon_instances, dependent: :destroy
    has_many :weapon_templates, through: :weapon_instances
    
    has_many :modifier_instances, dependent: :destroy
    has_many :modifier_templates, through: :modifier_instances
    
    has_many :shield_instances, dependent: :destroy
    has_many :shield_templates, through: :shield_instances
    
    has_many :stack_instances, dependent: :destroy
    has_many :stack_templates, through: :stack_instances
    
    has_many :armor_instances, dependent: :destroy
    
    has_many :consumable_instances, dependent: :destroy
    has_many :consumable_templates, through: :consumable_instances
    
    has_many :gear_instances, dependent: :destroy
    has_many :gear_templates, through: :gear_instances
    
    has_many :minion_instances, dependent: :destroy
    has_many :minion_templates, through: :minion_instances
    
    belongs_to :race
    has_many :perks, through: :race
    
  def meets_prereq?(skill_template)
    self.skill_templates.prerequsites.each do |prereq|
      case(prereq.prereq_type)
      when 'level'
        if not self.has_level?(prereq.value)
          return false
        end
      when 'skill'
        if not self.has_skill?(prereq.prereq_name)
          return false
        end
      when 'race'
        if not self.race.nil?
          return (self.race.name == prereq.prereq_name)
        end
      else
        return false
      end
    end
    return true
  end
  
  def has_skill?(name)
    self.skill_templates.each do |skill|
      if skill.name == name
        return true
      end
    end
    return false
  end
  
  def has_proficiency?(name)
    self.proficiency_templates.each do |prof|
      if prof.name == name
        return true
      end
    end
    return false
  end
  
  def has_level?(level)
    if self.level.nil?
      self.level = 1
      self.save
    end
    self.level >= level
  end
  
  def has_race?
    not self.race_id.nil?
  end

  
  def set_default_values
    self.level = 1
    self.toughness = 0
    self.wounds = 0
    self.money = 150
  end
  
  def spent_skill_points
    self.skill_templates.where("skill_type != ?", "free").count
  end
  
  def spent_proficiency_points
    points = 0
    self.proficiency_instances.each do |prof|
      points += prof.value
    end
    points
  end


  def current_shield
    self.shield_instances.each do |shield|
      if shield.in_use
        return shield
      end
    end
    return ShieldInstance.new
  end
  
  def current_armor
    self.armor_instances.each do |armor|
      if armor.in_use
        return armor
      end
    end
    return ArmorInstance.new
  end
  
  def current_skill_points
    points = level + 1 + Math.floor(level/5)
    points -= self.spent_skill_points
    points
  end
  
  def current_proficiency_points
    2 * level
  end
  
  def add_skill(candidate)
    
  end
  
  def drop_skill(id)
  end
  
  def add_proficiency(id)
    
  end
  
  def set_proficiency(id, tier)
    
  end
  
  
  
end
