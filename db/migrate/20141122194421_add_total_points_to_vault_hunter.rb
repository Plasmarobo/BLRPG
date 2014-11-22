class AddTotalPointsToVaultHunter < ActiveRecord::Migration
  def change
    add_column :vault_hunters, :total_attribute_points, :integer
    add_column :vault_hunters, :total_proficiency_points, :integer
    add_column :vault_hunters, :total_skill_points, :integer
  end
end
