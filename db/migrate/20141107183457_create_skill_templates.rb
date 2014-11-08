class CreateSkillTemplates < ActiveRecord::Migration
  def change
    create_table :skill_templates do |t|
      t.string :name
      t.string :type
      t.integer :cooldown
      t.integer :duration
      t.string :description
      t.integer :prerequsite_id

      t.timestamps
    end
  end
end
