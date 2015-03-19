class CreateMeleeWeaponInstances < ActiveRecord::Migration
  def change
    create_table :melee_weapon_instances do |t|
      t.integer :melee_weapon_template_id
      t.string :prefix
      t.string :postfix
      t.integer :current_recoil
      t.text :notes
      t.integer :vault_hunter_id

      t.timestamps
    end
  end
end
