class CreateGearTemplates < ActiveRecord::Migration
  def change
    create_table :gear_templates do |t|
      t.string :name
      t.integer :cost
      t.text :description
      t.integer :modifier_id

      t.timestamps
    end
  end
end
