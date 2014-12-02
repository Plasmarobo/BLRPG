class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skills, dependent: :destroy
    has_many :skill_templates, through: :skills
    has_many :proficiencies, dependent: :destroy
    has_many :attacks, dependent: :destroy
    has_many :attribute_instances, dependent: :destroy
    has_many :minions, dependent: :destroy
    belongs_to :race
    
  def meets_prereq?(skill_template)
    skill_template.prerequsites.each do |prereq|
      case(prereq.prereq_type)
      when 'attribute'
        if not self.has_attribute_inst?(prereq.prereq_name, prereq.value) then
          return false
        end
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
  
  def has_attribute_inst?(name, value)
    attribute_instance = self.find_attribute_inst_by_name(name)
    #Do not check for nil, a non-existant attribute is an error condition
    attribute_instance.value >= value
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

  def find_attribute_inst_by_name(name)
    self.attribute_instances.each do | attribute_inst |
      if attribute_inst.name == name
        return attribute_inst
      end
    end
    return nil
  end
  
  def create_default_attributes
    AttributeTemplate.find_each do |template|
      template.instance(self, 0)
    end
  end
  
  def set_default_values
    self.level = 1
    self.create_default_attributes()
    self.current_attribute_points = self.total_attribute_points = 9
    self.current_proficiency_points = self.total_proficiency_points = 2
    self.current_skill_points = self.total_skill_points = 2
    self.toughness = 0
    self.wounds = 0
    self.current_shield = 0
    self.shield = 0
    self.money = 150
  end
  
  def set_attribute(id, value)
    attribute_inst = self.attribute_instances.find(id)
    if attribute_inst.nil? then
        return false
    else
      delta = value - attribute_inst.value
      if self.current_attribute_points >= delta
        self.current_attribute_points -= delta
        attribute_inst.value = value
        if self.save() then
          attribute_inst.save()
          return true
        else
          return false
        end
      end
    end
    return false
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
