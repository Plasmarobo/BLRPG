class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skills
    has_many :skill_templates, through: :skills
    has_many :proficiencies
    has_many :attacks
    has_many :attribute_instances
    
  def meets_prereq(type, name, value)
    case(type)
    when 'attribute'
      return self.find_attribute_by_name(name).value >= value
    when 'level'
      return self.level >= value
    when 'skill'
      return self.skill_templates.find_by_name(name) != nil
    else
      return false
    end
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
