class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skill_instances, dependent: :destroy
    has_many :proficiencies, dependent: :destroy
    has_many :ranged_weapon_instances
    has_many :melee_weapon_instances
    has_many :modifiers
    has_many :shield_instances
    has_many :stack_instances
    has_many :armor_instances
    has_many :consumable_instances
    has_many :gear_instances
    
    has_many :minions, dependent: :destroy
    belongs_to :race
    has_many :perks, through: :race
    
    
  def meets_prereq?(skill_template)
    skill_template.prerequsites.each do |prereq|
      case(prereq.prereq_type)
      when 'level'
        if not self.has_level?(prereq.value)
          return false
        end
      when 'skill'
        if not self.has_skill?(prereq.prereq_name)
          return false
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
    self.proficiencies.each do |prof|
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
  
  def current_skill_points
  end

  def current_shield
    self.shield_instances.each do |shield|
      if shield.in_use
        return shield
      end
    end
    return nil
  end
  
  def current_armor
    self.armor_instances.each do |armor|
      if armor.in_use
        return armor
      end
    end
    return nil
  end
  
  def add_skill(candidate)
    if self.current_skill_points > 0 then
      if self.meets_prereq?(candiate) then
        self.current_skill_points -= 1
        if self.save() then
          candiate.instance(self)
          return true
        end
      end
    end
    return false
  end
  
  def drop_skill(id)
  end
  
  def add_proficiency(id)
    if self.current_proficiency_points > 0 then
      candidate = ProficiencyTemplate.find(id)
      if candidate.nil?
        return false
      else
        self.current_proficiency_points -= 1
        if self.save() then
          candidate.instance(self, 1)
          return true
        end
      end
    end
    return false
  end
  
  def set_proficiency(id, tier)
    candiate = self.proficiencies.find(id)
    if candiate.nil? then
      return false
    else
      delta = tier - candiate.tier
      if self.current_proficiency_points >= delta then
        if self.level <= tier
          candidate.tier = tier
          self.current_proficiency_points -= delta
          if self.save() then
            candiate.save()
            return true
          end
        end
      end
    end
    return false
  end
  
  
  
end
