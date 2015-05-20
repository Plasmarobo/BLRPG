class ShieldTemplate < ActiveRecord::Base
  has_many :modifier_templates
  has_many :shield_intances
  belongs_to :effects, foreign_key: :deplete_effect_id
  
  def instance(vault_hunter)
    ShieldInstance.create({vault_hunter_id: vault_hunter.id, shield_template_id: self.id, current_capacity: self.capacity, in_use: true})
  end
  
  def deplete_effect
    
    if self.deplete_effect_id == nil or (depleteEffect = Effect.find(self.deplete_effect_id)) == nil
      depleteEffect = Effect.new(name: "Recharge Delay", description: "Shield does not recharge on the turn it was depleted or the turn after depletion.");
    end
    depleteEffect
  end
end
