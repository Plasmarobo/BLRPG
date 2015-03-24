class CreateMinionInstances < ActiveRecord::Migration
  def change
    drop_table :minions
    create_table :minion_instances do |t|
      t.integer :vault_hunter_id
      t.integer :minion_template_id
      t.integer :hp
      t.integer :shield
      t.integer :armor

      t.timestamps
    end
  end
end
