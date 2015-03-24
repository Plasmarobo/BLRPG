class MergeWeapons < ActiveRecord::Migration
  def change
    drop_table :melee_weapon_instances
    drop_table :melee_weapon_templates
    drop_table :weapon_instances
    rename_table :ranged_weapon_instances, :weapon_instances
    rename_table :ranged_weapon_templates, :weapon_templates
  end
end
