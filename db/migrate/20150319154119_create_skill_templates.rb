class CreateSkillTemplates < ActiveRecord::Migration
  def change
    change_table :skill_templates do |t|
      t.column :cost, :integer
    end
  end
end
