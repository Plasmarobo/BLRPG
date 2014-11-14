class ReworkProficiencies < ActiveRecord::Migration
  def change
    remove_column :proficiencies, :pool 
    remove_column :proficiencies, :points
    remove_column :proficiencies, :attribute_name
    remove_column :proficiency_templates, :attribute_name
    add_column    :proficiencies, :tier, :integer
  end
end
