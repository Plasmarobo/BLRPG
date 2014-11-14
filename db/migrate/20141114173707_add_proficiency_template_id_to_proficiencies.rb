class AddProficiencyTemplateIdToProficiencies < ActiveRecord::Migration
  def change
    add_column :proficiencies, :proficiency_template_id, :integer
  end
end
