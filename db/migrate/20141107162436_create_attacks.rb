class CreateAttacks < ActiveRecord::Migration
  def change
    create_table :attacks do |t|
      t.string :name
      t.integer :pool
      t.integer :dmg
      t.string :misc

      t.timestamps
    end
  end
end
