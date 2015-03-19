class CreateShieldInstances < ActiveRecord::Migration
  def change
    create_table :shield_instances do |t|
      t.integer :vault_hunter_id
      t.integer :current_capacity
      t.integer :shield_template_id
      t.boolean :in_use

      t.timestamps
    end
  end
end
