class CreateRangedWeaponTemplates < ActiveRecord::Migration
  def change
    create_table :ranged_weapon_templates do |t|
      t.string :name
      t.integer :accuracy
      t.integer :recoil
      t.integer :range
      t.integer :fire_mode
      t.integer :damage
      t.integer :cost
      t.text :description

      t.timestamps
    end
  end
end
