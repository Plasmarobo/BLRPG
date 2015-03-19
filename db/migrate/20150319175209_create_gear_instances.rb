class CreateGearInstances < ActiveRecord::Migration
  def change
    create_table :gear_instances do |t|
      t.integer :vault_hunter_id
      t.integer :modifier_id

      t.timestamps
    end
  end
end
