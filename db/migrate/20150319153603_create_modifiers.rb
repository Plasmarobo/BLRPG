class CreateModifiers < ActiveRecord::Migration
  def change
    create_table :modifiers do |t|
      t.integer :skill_id
      t.integer :perk_id
      t.integer :gear_instance_id
      t.integer :consumable_instance_id
      t.integer :ranged_weapon_instance_id
      t.integer :melee_weapon_instance_id
      t.string :name
      t.string :target
      t.integer :amount
      t.integer :duration_id

      t.timestamps
    end
  end
end
