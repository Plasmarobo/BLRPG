class WeaponInstance < OwnedInstance
  self.table_name = :weapon_instances
  belongs_to :weapon_template
end
