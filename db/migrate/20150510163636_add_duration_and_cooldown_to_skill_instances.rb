class AddDurationAndCooldownToSkillInstances < ActiveRecord::Migration
  def change
    change_table :skill_instances do |t|
      t.column :duration, :integer
      t.column :cooldown, :integer
    end
  end
end
