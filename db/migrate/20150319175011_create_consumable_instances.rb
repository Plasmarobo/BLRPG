class CreateConsumableInstances < ActiveRecord::Migration
  def change
    create_table :consumable_instances do |t|
      t.integer :consumable_template_id
      t.integer :vault_hunter_id
      t.integer :modifier_id
      t.integer :current_uses

      t.timestamps
    end
  end
end
