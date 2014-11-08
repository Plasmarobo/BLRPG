class CreateProficiencyTemplates < ActiveRecord::Migration
  def change
    create_table :proficiency_templates do |t|
      t.string :name
      t.integer :pool
      t.string :attribute
      t.integer :points

      t.timestamps
    end
  end
end
