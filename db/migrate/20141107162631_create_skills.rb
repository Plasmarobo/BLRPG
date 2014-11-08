class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :type
      t.integer :cooldown
      t.integer :duration
      t.text :description
      t.integer :prerequsite_id

      t.timestamps
    end
  end
end
