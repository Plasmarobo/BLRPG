class CreateMinionSkills < ActiveRecord::Migration
  def change
    create_table :minion_skills do |t|
      t.string :name
      t.integer :cost
      t.text :description
      t.integer :minion_template_id

      t.timestamps
    end
  end
end
