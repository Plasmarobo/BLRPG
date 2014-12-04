class ChangeCurrentPointsToSpentPoints < ActiveRecord::Migration
  def change
    rename_column :vault_hunters, :current_skill_points, :spent_skill_points
    rename_column :vault_hunters, :current_proficiency_points, :spent_proficiency_points
    rename_column :vault_hunters, :current_attribute_points, :spent_attribute_points
  end
end
