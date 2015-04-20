class ArmorTemplate < ActiveRecord::Base
  has_many :modifier_templates
  has_many :armor_instances
  
  def instance(vault_hunter)
    ArmorInstance.create({vault_hunter_id: vault_hunter.id, armor_template_id: self.id, current_deflect: self.deflect, in_use: true})
  end
end
