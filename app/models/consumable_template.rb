class ConsumableTemplate < ActiveRecord::Base
  has_many :modifier_templates
  has_many :consumable_instances
  
  def instance(vault_hunter)
    ConsumableInstance.create({vault_hunter_id: vault_hunter.id, consumable_template_id: self.id, current_uses: self.max_uses})
  end
end
