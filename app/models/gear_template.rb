class GearTemplate < ActiveRecord::Base
  has_many :modifier_templates
  has_many :gear_instances
  
  def instance(vault_hunter)
    GearInstance.create({vault_hunter_id: vault_hunter.id, gear_template_id: self.id})
  end
end
