class ChangeDurationSkillIdToTemplateId < ActiveRecord::Migration
  def change
    change_table :durations do |t|
      t.rename :skill_id, :skill_instance_id
    end
  end
end
