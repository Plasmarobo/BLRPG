class CreatePrerequsites < ActiveRecord::Migration
  def change
    create_table :prerequsites do |t|
      t.integer :skill_id
      t.string :prereq_type
      t.integer :value

      t.timestamps
    end
  end
end
