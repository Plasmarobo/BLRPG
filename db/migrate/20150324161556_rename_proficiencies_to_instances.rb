class RenameProficienciesToInstances < ActiveRecord::Migration
  def change
    rename_table :proficiencies, :proficiency_instances
  end
end
