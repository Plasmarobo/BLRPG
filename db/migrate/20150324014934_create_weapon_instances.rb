class CreateWeaponInstances < ActiveRecord::Migration
  def change
    create_table :weapon_instances do |t|
      t.integer :ranged_weapon_instance_id
      t.integer :melee_weapon_instance_id
      t.integer :vault_hunter_id
      t.boolean :is_equipped

      t.timestamps
    end
  end
end
