class CreateConsumableTemplates < ActiveRecord::Migration
  def change
    create_table :consumable_templates do |t|
      t.string :name
      t.integer :cost
      t.integer :max_uses
      t.text :description
      t.integer :modifier_id
      t.integer :duration

      t.timestamps
    end
  end
end
