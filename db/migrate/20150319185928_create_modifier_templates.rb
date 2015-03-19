class CreateModifierTemplates < ActiveRecord::Migration
  def change
    create_table :modifier_templates do |t|
      t.integer :skill_template_id
      t.integer :perk_id
      t.integer :gear_template_id
      t.integer :consumable_template_id
      t.integer :ranged_weapon_template_id
      t.integer :melee_weapon_template_id
      t.integer :duration
      t.integer :name
      t.string :target
      t.integer :amount
      t.integer :effect_id
      t.integer :armor_template_id
      t.integer :shield_template_id
      t.integer :stack_template_id

      t.timestamps
    end
  end
end
