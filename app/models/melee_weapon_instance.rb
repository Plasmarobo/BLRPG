class MeleeWeaponInstance < ActiveRecord::Base
  has_many :modifiers, dependent: :destroy
  belongs_to :vault_hunter
  belongs_to :melee_weapon_template
end
