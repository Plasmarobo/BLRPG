class ProficiencyTemplate < ActiveRecord::Base

    def instance(vault_hunter)
      ProficiencyInstance.create(vault_hunter_id: vault_hunter.id, name: self.name, tier: 1, proficiency_template_id: self.id, value: 1)
    end
end
