class CreateMinionTemplates < ActiveRecord::Migration
  def change
    create_table :minion_templates do |t|
      t.string :name
      t.integer :max_hp
      t.integer :max_shield
      t.integer :max_armor
      t.text :description
      t.integer :size
      t.boolean :is_beast

      t.timestamps
    end
  end
end
