class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.integer :race_id
      t.text :description
      t.string :type
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
