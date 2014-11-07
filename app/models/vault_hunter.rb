class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skills
    has_many :skill_templates, through: :skills
    has_many :proficiencies
    has_many :attacks
    
  def meets_prereq(type, name, value)
    case(type)
    when 'attribute'
      return self.attributes.find_by_name(name).value >= value
    when 'level'
      return self.level >= value
    when 'skill'
      return self.skill_templates.find_by_name(name) != nil
    else
      return false
    end
  end
end
