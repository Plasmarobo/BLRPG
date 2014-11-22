class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skills
    has_many :skill_templates, through: :skills
    has_many :proficiencies
    has_many :attacks
    has_many :attribute_instances
    has_many :minions
    
  def meets_prereq(skill_template)
    result = true
    skill_template.prerequsites do |prereq|
    
      case(prereq.prereq_type)
      when 'attribute'
        result |= self.find_attribute_by_name(prereq.name).value >= prereq.value
      when 'level'
        result |= self.level >= prereq.value
      when 'skill'
        result |= self.skill_templates.find_by_name(prereq.name).first != nil
      else
        result = false
      end
    end
    return result
  end

  def find_attribute_by_name(name)
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
end
