class CreateSkillInstances < ActiveRecord::Migration
  def change
    create_table :skill_instances do |t|
      t.integer :skill_template_id
      t.integer :vault_hunter_id
      t.integer :level_acquired

      t.timestamps
    end
  end
end
