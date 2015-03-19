class RemoveModifierFromTemplates < ActiveRecord::Migration
  def change
    remove_column :armor_templates, :modifier_id
    remove_column :consumable_templates, :modifier_id
    remove_column :effects, :modifier_id
    remove_column :gear_templates, :modifier_id
    remove_column :melee_weapon_templates, :modifier_id
    remove_column :ranged_weapon_templates, :modifier_id
  end
end
