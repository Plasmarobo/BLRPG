class ShieldTemplate < ActiveRecord::Base
  has_many :modifier_templates
  has_many :shield_intances
  
  def instance(vault_hunter)
    ShieldInstance.create({vault_hunter_id: vault_hunter.id, shield_template_id: self.id, current_capacity: self.capacity, in_use: true})
  end
end
