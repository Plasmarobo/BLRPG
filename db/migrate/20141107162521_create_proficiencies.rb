class CreateProficiencies < ActiveRecord::Migration
  def change
    create_table :proficiencies do |t|
      t.string :name
      t.integer :pool
      t.integer :points
      t.string :attribute

      t.timestamps
    end
  end
end
