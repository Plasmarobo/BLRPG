class ProficiencyTemplate < ActiveRecord::Base

    def instance(vault_hunter, points)
      attrib = AttributeInstance.where("vault_hunter_id = ? AND name = ?", vault_hunter.id, self.attribute_name).first
      if(attrib == nil) then
        pool = points.to_i
      else
        pool = attrib.value + points.to_i
      end
      Proficiency.create(vault_hunter_id: vault_hunter.id, name: self.name, attribute_name: self.attribute_name, pool: pool, points: points)
    end
end
