class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.integer :skill_template_id
      t.string :prereq_type
      t.string :prereq_name
      t.integer :value

      t.timestamps
    end
  end
end
