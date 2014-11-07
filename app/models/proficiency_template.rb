class ProficiencyTemplate < ActiveRecord::Base
    def instance(vault_hunter, points)
       pool = vault_hunter.find_attribute_by_name(self.attribute_name).value + points
       Proficiency.create(vault_hunter_id: vault_hunter.id, name: self.name, attribute_name: self.attribute_name, pool: pool, points: points)
    end
end
