class ModifierTemplate < ActiveRecord::Base
  belongs_to :skill_template
  belongs_to :perk
  belongs_to :gear_template
  belongs_to :ranged_weapon_template
  belongs_to :melee_weapon_template
  belongs_to :effect
  belongs_to :armor_template
  belongs_to :sheild_template
  belongs_to :stack_template
end
