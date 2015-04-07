class AddPrerequistesToSkillTemplates < ActiveRecord::Migration
  def change
    change_table :skill_templates do |t|
      t.column :prerequisites, :string
    end
  end
end
