class CreateArmorTemplates < ActiveRecord::Migration
  def change
    create_table :armor_templates do |t|
      t.string :name
      t.integer :weight
      t.integer :deflect
      t.integer :cost
      t.text :description

      t.timestamps
    end
  end
end
