class CreateArmorInstances < ActiveRecord::Migration
  def change
    create_table :armor_instances do |t|
      t.integer :vault_hunter_id
      t.integer :armor_template_id
      t.integer :modifier_id

      t.timestamps
    end
  end
end
