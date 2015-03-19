class CreateShieldTemplates < ActiveRecord::Migration
  def change
    create_table :shield_templates do |t|
      t.string :name
      t.integer :capacity
      t.integer :recharge
      t.integer :deflect
      t.integer :cost
      t.string :description
      t.integer :vault_hunter_id

      t.timestamps
    end
  end
end
