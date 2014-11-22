class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skills
    has_many :skill_templates, through: :skills
    has_many :proficiencies
    has_many :attacks
    has_many :attribute_instances
    has_many :minions
    
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
  
  def has_level?(level)
    if self.level.nil?
      self.level = 1
      self.save
    end
    self.level >= level
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
end
