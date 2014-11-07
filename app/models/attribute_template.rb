class AttributeTemplate < ActiveRecord::Base
  def instance(vault_hunter, points)
    Attribute.create(vault_hunter_id:vault_hunter.id, name: self.name, value: points, short:self.short) 
  end
end
