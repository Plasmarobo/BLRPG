class CreateMeleeWeaponTemplates < ActiveRecord::Migration
  def change
    create_table :melee_weapon_templates do |t|
      t.string :name
      t.integer :accuracy
      t.integer :recoil
      t.integer :damage
      t.integer :cost
      t.text :description

      t.timestamps
    end
  end
end
