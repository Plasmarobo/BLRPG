class Revision15 < ActiveRecord::Migration
  def change
    drop_table :attribute_instances
    drop_table :attribute_templates
    drop_table :attacks
    change_table :vault_hunters do |t|
      t.remove :total_attribute_points, :spent_attribute_points
      t.remove :shield, :current_shield
      t.remove :total_proficiency_points, :total_skill_points
      t.remove :spent_skill_points, :spent_proficiency_points
      t.column :misc_atk_bonus, :integer
      t.column :misc_ranged_atk_bonus, :integer
      t.column :misc_melee_atk_bonus, :integer
      t.column :misc_dmg_bonus, :integer
      t.column :misc_ranged_dmg_bonus, :integer
      t.column :misc_melee_dmg_bonus, :integer
      t.column :current_initiative, :integer
    end
    
    change_table :minions do |t|
      t.column :hp, :integer
      t.column :max_hp, :integer
      t.column :armor, :integer
      t.column :max_armor, :integer
      t.column :shield, :integer
      t.column :max_shield, :integer
    end
    
  end
end
