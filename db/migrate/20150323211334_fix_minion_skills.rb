class FixMinionSkills < ActiveRecord::Migration
  def change
    rename_table :minion_skills, :minion_skill_templates
    create_table :minion_skill_instances do |t|
      t.integer :minion_skill_template_id
      t.integer :minion_instance_id
      t.integer :duration_id
    end
  end
end
