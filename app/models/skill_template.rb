class SkillTemplate < ActiveRecord::Base
  has_many :modifier_templates
  has_many :prerequsites
  
  def instance(vault_hunter)
    return SkillInstance.create(skill_template_id: self.id, vault_hunter_id: vault_hunter.id, level_acquired: vault_hunter.level)
  end
  
end
