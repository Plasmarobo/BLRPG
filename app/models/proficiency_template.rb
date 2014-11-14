class ProficiencyTemplate < ActiveRecord::Base

    def instance(vault_hunter, tier)
      Proficiency.create(vault_hunter_id: vault_hunter.id, name: self.name, tier: tier, proficiency_template_id: self.id)
    end
end
