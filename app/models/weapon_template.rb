class WeaponTemplate < ActiveRecord::Base
  has_many :weapon_instances
  
  def instance(vault_hunter)
    WeaponInstance.create({vault_hunter_id: vault_hunter.id, weapon_template_id: self.id, ammunition: 0, notes: "", prefix: "", postfix: "", current_recoil: 0})
  end
end
