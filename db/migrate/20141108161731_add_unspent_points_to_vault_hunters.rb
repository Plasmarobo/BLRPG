class AddUnspentPointsToVaultHunters < ActiveRecord::Migration
  def change
    add_column :vault_hunters, :current_proficiency_points, :integer
    add_column :vault_hunters, :current_skill_points, :integer
  end
end
