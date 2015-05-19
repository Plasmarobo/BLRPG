class SkillTemplate < ActiveRecord::Base
  has_many :modifier_templates
  has_many :prerequsites
  
  def instance(vault_hunter)
    return SkillInstance.create(skill_template_id: self.id, vault_hunter_id: vault_hunter.id, level_acquired: vault_hunter.level)
  end
  
  def prerequsites_info
    info = {}
    info[:level] = "No level restriction"
    info[:race] = "No race restriction"
    info[:skills] = "No skill requirements"
    skills = []
    Prerequisite.where(skill_template_id: self.id).each do |prereq|
      case(prereq.prereq_type)
      when 'level'
        info[:level] = "Must be at least level #{prereq.value}"
      when 'skill'
        skills << prereq.prereq_name
      when 'race'
        info[:race] = "Race required: #{prereq.prereq_name}"
      end
    end
    if skills.length > 0
      info[:skills] = ""
      skills.each_with_index do |skill_name, index|
        if index != 0
          info[:skills] += ", "
        end
        info[:skills] += skill_name
      end
    end
    info
  end
  
end
