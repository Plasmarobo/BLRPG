class Modifier < ActiveRecord::Base
  belongs_to :armor_instance
  belongs_to :consumable_instance
  belongs_to :gear_instance
  belongs_to :melee_weapon_instance
  belongs_to :perk
  belongs_to :ranged_weapon_instance
  belongs_to :shield_instance
  belongs_to :skill_instance
end
