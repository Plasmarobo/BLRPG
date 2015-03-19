class CreateRangedWeaponInstances < ActiveRecord::Migration
  def change
    create_table :ranged_weapon_instances do |t|
      t.integer :ranged_weapon_template_id
      t.integer :ammunition
      t.text :notes
      t.string :prefix
      t.string :postfix
      t.integer :current_recoil
      t.integer :vault_hunter_id

      t.timestamps
    end
  end
end
