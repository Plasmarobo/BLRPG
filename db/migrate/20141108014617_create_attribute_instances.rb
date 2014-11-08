class CreateAttributeInstances < ActiveRecord::Migration
  def change
    create_table :attribute_instances do |t|
      t.string :name
      t.integer :value
      t.string :short
      t.integer :vault_hunter_id

      t.timestamps
    end
  end
end
