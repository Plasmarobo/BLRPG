class FixRelationsForModifiers < ActiveRecord::Migration
  def change
    change_table :modifiers do |t|
      t.rename :skill_id, :skill_instance_id
      t.column :effect_id, :integer
      t.column :armor_instance_id, :integer
      t.column :shield_instance_id, :integer
      t.column :stack_instance_id, :integer
    end
    
    change_table :armor_instances do |t|
      t.remove :modifier_id
    end
    
    change_table :consumable_instances do |t|
      t.remove :modifier_id
    end
    
    change_table :gear_instances do |t|
      t.remove :modifier_id
    end
    
    change_table :armor_templates do |t|
      t.column :modifier_id, :integer
    end
    
    change_table :melee_weapon_templates do |t|
      t.column :modifier_id, :integer
    end
    
    change_table :ranged_weapon_templates do |t|
      t.column :modifier_id, :integer
    end
    
    drop_table :skills
  end
end
