class RangedWeaponInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :ranged_weapon_template
  has_many :modifiers
end
