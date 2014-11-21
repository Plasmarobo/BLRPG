class CreateMinions < ActiveRecord::Migration
  def change
    create_table :minions do |t|
      t.integer :vault_hunter_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
